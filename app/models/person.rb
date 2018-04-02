class Person < SoftDeleteBaseModel

  # Associations
  has_many :people_steps
  has_many :steps, through: :people_steps
  has_many :documents
  belongs_to :organization
  belongs_to :owner, class_name: 'Staff'

  # Callbacks
  after_initialize :set_default_status

  # Attributes accessors
  attr_accessor :product_id

  # Enum & constants
  GENDER_TYPES = [['Nữ', false], ['Nam', true]].freeze
  SAMPLE_TYPES = [['Please choose', '0'], ['Option 1', '1'], ['Option 2', '2']].freeze
  enum status: { prospect: 0, lead: 1, customer: 2, archive: 3 }

  # Validations methods
  validates :first_name, :phone, presence: true
  validates :product_id, presence: true, on: :create
  validates :phone, numericality: true
  validates :nic_number, numericality: true, allow_blank: true
  validate :product_validate
  validate :product_with_nic_validate # , if: -> { new_record? || nic_number_changed? }

  def gender_name
    gender.nil? ? nil : gender ? 'Nam' : 'Nữ'
  end

  def update_fields(object_id, form_id, person_params, params)
    form_values_params = params[:form_values]
    support_profiles_params = params[:support_profiles]

    ActiveRecord::Base.transaction do
      if update(person_params)
        save_form_values(form_values_params, object_id, form_id)
        save_support_profiles(support_profiles_params, object_id)
      end
      raise ActiveRecord::Rollback if errors.any?
    end
    self
  end

  def current_step
    people_steps.order(created_at: :desc).first
  end


  private

  def save_form_values(params, object_id, form_id)
    params.each do |field_id, value|
      form_value = FormValue.find_or_create_by(form_id: form_id, object_id: object_id, form_field_id: field_id)
      form_value.value = value
      next if form_value.save
      value_errors = form_value.errors.messages.first
      error_message = value_errors&.join(' ')
      errors[field_id] << error_message if error_message
    end
  end

  def save_support_profiles(params, object_id)
    # Save to support_profiles
    params&.each do |id, obj_value|
      next if obj_value.values.reject(&:blank?).empty?
      profile = SupportProfile.find_or_create_by(id: id)
      profile.assign_attributes(obj_value.permit!.to_h)
      profile.person_id = object_id
      next if profile.save
      value_errors = profile.errors.messages.first
      error_message = value_errors&.join(' ')
      errors['support_profiles'][id] << error_message if error_message
    end
  end

  def set_default_status
    self.status = :prospect if new_record?
  end

  def product_validate
    if product_id == '1'
      errors.add(:school, :blank) unless school.present?
    elsif product_id == '2'
      errors.add(:merchandise, :blank) unless merchandise.present?
    end
  end

  def product_with_nic_validate
    return if nic_number.blank?
    service = PersonDataService.new
    errors.add(:nic_number, 'exists with this product') unless service.nic_validate?(nic_number, product_id)
  end
end
