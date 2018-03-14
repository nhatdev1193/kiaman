class Person < SoftDeleteBaseModel
  has_many :people_steps
  has_many :steps, through: :people_steps

  after_initialize :set_default_status

  attr_accessor :product_id

  GENDER_TYPES = [['Nữ', false], ['Nam', true]].freeze

  validates :first_name, :phone, presence: true
  validates :product_id, presence: true, on: :create
  validates :phone, numericality: true
  validates :nic_number, numericality: true, allow_blank: true
  validate :product_validate

  enum status: { prospect: 0, lead: 1, customer: 2, archive: 3 }

  def gender_name
    gender.nil? ? nil : gender ? 'Nam' : 'Nữ'
  end

  def current_step
    people_steps&.last&.step
  end

  def update_fields(person_params, form_values_params)
    Person.transaction do
      FormValue.transaction do
        if update(person_params)
          # Save to form_values
          form_values_params.each do |field_id, value|
            form_value = FormValue.find_or_create_by(form_id: current_step.form_id, form_field_id: field_id)
            form_value.value = value
            next unless form_value.save
            value_errors = form_value.errors.messages.first
            error_message = value_errors&.join(' ')
            errors[field_id] << error_message if error_message
          end
        end
      end
      raise ActiveRecord::Rollback if errors.any?
    end
    self
  end

  private

  def set_default_status
    self.status = :prospect if new_record?
  end

  def first_person_step
    people_steps.order(created_at: :desc).first
  end

  def product_validate
    if product_id == '1'
      errors.add(:school, :blank) unless school.present?
    elsif product_id == '2'
      errors.add(:merchandise, :blank) unless merchandise.present?
    end
  end
end
