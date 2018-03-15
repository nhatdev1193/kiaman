class Staff::PeopleController < Staff::BaseController
  before_action :set_person, only: [:show, :edit, :update]
  before_action :set_step_and_dynamic_form, only: [:show, :edit, :update]

  def index
    service = PersonDataService.new
    @people_steps = service.person_list
                           .paginate(page: params[:page], per_page: params[:per_page])
  end

  def new
    @person = Person.new
  end

  def show; end

  def edit; end

  def create
    ActiveRecord::Base.transaction do
      @person = Person.new(person_params)

      if @person.save!
        redirect_to staff_people_path, notice: 'Prospect was successfully created.' if person_step(@person, person_params[:product_id])
      else
        render :new
      end
    end
  rescue => _exception
    render :new
  end

  def create_multi
    ActiveRecord::Base.transaction do
      people_params[:people].each do |cus_params|
        next if invalid_person?(cus_params[:person])

        cus_params[:person][:product_id] = people_params[:product_id]
        @person = Person.new(cus_params[:person])

        if @person.save!
          person_step(@person, people_params[:product_id])
        else
          render :new
        end
      end
      redirect_to staff_people_path
    end
  rescue => _exception
    render :new
  end

  def update
    @person = @person.update_fields(params[:object_id], @current_step.form_id, person_params, form_values_params)
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def set_step_and_dynamic_form
    @current_step = Step.find(params[:step])
    @dynamic_form = Form.includes(form_fields: :form_input).find_by_id(@current_step.form_id)
  end

  def person_params
    params[:person].delete(:merchandise) if params[:person][:product_id] == '1'
    params[:person].delete(:school) if params[:person][:product_id] == '2'
    params.require(:person).permit(:product_id, :last_name, :first_name, :gender, :phone, :birthday, :school, :merchandise, :nic_number)
  end

  def people_params
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
  def person_step(person, product_id)
    product = Product.find product_id
    people_step = person.people_steps.build(step: product.first_step, created_staff_id: current_staff.id,
                                            assigned_staff_id: current_staff.id, assigned_at: Time.now)

    return false unless people_step.save

    people_step.next_step!(current_staff.id)
  end

  def invalid_person?(person)
    person[:last_name].blank? && person[:first_name].blank? && person[:phone].blank? && person[:gender].blank? && person[:birthday].blank?
  end
end
