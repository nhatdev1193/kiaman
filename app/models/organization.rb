class Organization < SoftDeleteBaseModel
  include Parentable

  # Associations
  has_many :roles
  has_many :staffs, through: :roles
  has_many :people

  # Validations
  validates :name, presence: true
end
