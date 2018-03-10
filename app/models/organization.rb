class Organization < SoftDeleteBaseModel
  include Parentable

  # Associations
  has_many :roles
  has_many :staffs, through: :roles

  # Validations
  validates :name, presence: true
end
