class Person < SoftDeleteBaseModel
  has_many :people_steps
  has_many :steps, through: :people_steps

  after_initialize :set_default_status

  attr_accessor :product_id

  GENDER_TYPES = [['Nữ', false], ['Nam', true]].freeze

  validates :first_name, :phone, :product_id, presence: true
  validates :phone, numericality: true
  validate :product_validate

  enum status: { prospect: 0, lead: 1, customer: 2 }

  def product_name
    first_person_step&.step&.product_name
  end

  def branch_name
    first_person_step&.branch_name
  end

  def assignee_name
    first_person_step&.assignee_name
  end

  def gender_name
    gender.nil? ? nil : gender ? 'Nam' : 'Nữ'
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
