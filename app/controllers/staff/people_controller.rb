class Staff::PeopleController < Staff::BaseController
  before_action :person_service, only: [:index, :nic_check, :create_normal_prospect, :csv_upload, :create_fast_prospect]
  before_action :set_person, only: [:show, :edit, :update]
  before_action :set_step_and_dynamic_form, only: [:show, :edit, :update]
  before_action :set_cities, only: [:show, :edit]
  before_action :retrieve_form_values, only: [:show, :edit]

  def index
    service = PersonDataService.new
    @people_steps = service.person_list
                           .paginate(page: params[:page], per_page: params[:per_page])

    @person = Person.new # For creating new person with in modal popup form
  end

  def show; end

  def edit; end

  def create_normal_prospect
    ActiveRecord::Base.transaction do
      @person = person_params[:nic_number].present? ? Person.find_or_initialize_by(nic_number: person_params[:nic_number]) : Person.new
      @person.assign_attributes(person_params)
      nic_check = @service.nic_validate?(@person.nic_number, @person.product_id)

      if nic_check
        if @person.save
          if create_first_step_for_person(@person, @person.product_id)
            # TODO: Need to handle errors if failed to create first step
            respond_to do |f|
              f.js { ajax_redirect_to(staff_people_path, 'Tạo prospect thành công.') }
            end
          end
        else
          respond_to do |f|
            f.js {
              render partial: 'staff/partials/form_errors',
                     locals: { errors: @person.errors },
                     status: 422
            }
          end
        end
      else
        @person.errors.add(:nic_number, 'exists with this product')

        respond_to do |f|
          f.js {
            render partial: 'staff/partials/form_errors',
                   locals: { errors: @person.errors },
                   status: 422
          }
        end
      end
    end
  end

  def new_fast_prospect
    @error_lines = {}
  end

  def create_fast_prospect
    person_records = []
    all_person_records_are_valid = true
    @error_lines = {}
    arr_nic = people_params[:people].map { |e| e[:person][:nic_number] }

    people_params[:people].each_with_index do |psp, line|
      pers_params = psp[:person]
      person = pers_params[:nic_number].present? ? Person.find_or_initialize_by(nic_number: pers_params[:nic_number]) : Person.new
      person.assign_attributes(pers_params)
      person.product_id = people_params[:product_id]

      if person.validate && @service.nic_validate?(person.nic_number, person.product_id) && (person.nic_number.blank? || arr_nic.count(person.nic_number) == 1)
        person_records.push(person)
      else
        all_person_records_are_valid = false
        @error_lines[line + 1] = person.errors.messages.keys#.map(&:to_s)
      end
    end

    if all_person_records_are_valid
      if person_records.empty?
        notice_msg = '0 prospect được nhập'
      else
        ActiveRecord::Base.transaction do
          person_records.each do |record|
            create_first_step_for_person(record, people_params[:product_id]) if record.save!
          end
        end
        notice_msg = "Tạo prospect thành công: Bạn đã nhập thành công #{person_records.count}/#{person_records.count} prospects"
      end

      redirect_to staff_people_path, notice: notice_msg
    else
      render :new_fast_prospect
    end
  rescue => _exception
    render :new_fast_prospect
  end

  # Check exist nic
  def nic_check
    person = Person.find_by_nic_number(params[:nic_number])

    res_data = if @service.nic_validate?(params[:nic_number], params[:product_id])
                 { message: 'Có thể tạo', code: 200 }
               else
                 { message: "CMND đã tồn tại! Hãy nhập CMND khác. <br> #{person.last_name} #{person.first_name} - #{person.status}", code: 409 }
               end
    render json: res_data
  end

  def update
    @person = @person.update_fields(params[:object_id], @current_step.form_id, person_params, form_values_params)
  end

  def csv_upload
    all_person_records_are_valid, error_lines, person_records = import_csv

    if all_person_records_are_valid
      ActiveRecord::Base.transaction do
        person_records.each do |record|
          create_first_step_for_person(record, params[:person][:product_id]) if record.save!
        end
      end
      redirect_to staff_people_path, notice: "Tạo prospect thành công: Bạn đã nhập thành công #{person_records.count}/#{person_records.count} prospects"
    else
      redirect_to staff_people_path, alert: "Đã xảy ra lỗi: Prospect xảy ra lỗi tại các dòng #{error_lines.join(', ')}"
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def set_step_and_dynamic_form
    @current_step = Step.find(params[:step])
    @dynamic_form = Form.includes(form_fields: :form_input).find_by_id(@current_step.form_id)
    @form_fields = @dynamic_form.form_fields
  end

  def set_cities
    @cities = VenueService.new.fetch_cities
  end

  def retrieve_form_values
    form_values = FormValue.where(form_id: @dynamic_form.id, object_id: @person.id, form_field_id: @form_fields.ids)
    @form_fields = @form_fields.each { |field| field.field_value = form_values.detect { |fv| field.id == fv.form_field_id }&.value }
  end

  def person_params
    params[:person].delete(:merchandise) if params[:person][:product_id] == '1'
    params[:person].delete(:school) if params[:person][:product_id] == '2'
    params.require(:person).permit(:product_id, :last_name, :first_name, :gender, :phone, :birthday, :school, :merchandise, :nic_number)
  end

  def people_params
    params[:people][:people].delete_if { |item| invalid_person?(item[:person]) }
    params[:people][:people].each { |c| c[:person].delete(:merchandise) } if params[:people][:product_id] == '1'
    params[:people][:people].each { |c| c[:person].delete(:school) } if params[:people][:product_id] == '2'
    params.require(:people).permit(
      :product_id,
      people: [
        person: [
          :last_name, :first_name, :gender, :phone, :birthday, :school, :merchandise, :nic_number
        ]
      ]
    )
  end

  def form_values_params
    params.require(:form_values).permit(@dynamic_form.form_fields.map { |field| field.id.to_s })
  end

  # Store 1st step of flow into people_steps
  # Move next step if person info & 1st step stored successful
  def create_first_step_for_person(person, product_id)
    product = Product.find product_id
    people_step = person.people_steps.build(step: product.first_step, created_staff_id: current_staff.id,
                                            assigned_staff_id: current_staff.id, assigned_at: Time.now)

    return false unless people_step.save

    people_step.next_step!(current_staff.id)
  end

  def invalid_person?(person)
    person[:last_name].blank? && person[:first_name].blank? && person[:phone].blank? &&
      person[:gender].blank? && person[:birthday].blank? && person[:nic_number].blank?
  end

  def person_service
    @service = PersonDataService.new
  end

  def gender(str)
    str == 'Nam'
  end

  # Use for create prospects by CSV
  # Input: csv file
  # Output:
  # # all_person_records_are_valid: true or false
  # # error_lines: array line error
  # # person_records: array person object
  def import_csv
    require 'csv'

    dynamic_header, dynamic_field = if params[:person][:product_id] == '1'
                                      ['Trường', 'school']
                                    elsif params[:person][:product_id] == '2'
                                      ['Mặt hàng', 'merchandise']
                                    end

    csv_selected_columns = [
      'Họ và tên lót',
      'Tên',
      'SĐT',
      dynamic_header,
      'CMND',
      'Giới tính',
      'Ngày sinh'
    ]

    db_columns_map = [
      'last_name',
      'first_name',
      'phone',
      dynamic_field,
      'nic_number',
      'gender',
      'birthday'
    ]

    person_records = []
    all_person_records_are_valid = true
    error_lines = []

    csv = CSV.read(params[:person][:file].path, headers: true)
    arr_nic = csv['CMND'].compact

    csv.each_with_index do |row, line|
      hash = {}

      row.headers.each_with_index do |header, idx|
        column_idx = csv_selected_columns.find_index(header)
        next unless column_idx
        hash[db_columns_map[column_idx]] = row[idx]
      end

      person = hash['nic_number'].present? ? Person.find_or_initialize_by(nic_number: hash['nic_number']) : Person.new
      person.assign_attributes(
        last_name: hash['last_name'],
        first_name: hash['first_name'],
        phone: hash['phone'],
        gender: gender(hash['gender']),
        birthday: hash['birthday'],
        product_id: params[:person][:product_id]
      )
      # Assign value for school or merchandise follow product_id
      person[dynamic_field] = hash[dynamic_field]

      if person.validate && @service.nic_validate?(person.nic_number, person.product_id) && (person.nic_number.blank? || arr_nic.count(person.nic_number) == 1)
        person_records.push(person)
      else
        all_person_records_are_valid = false
        error_lines << line + 2
      end
    end
    [all_person_records_are_valid, error_lines, person_records]
  end
end
