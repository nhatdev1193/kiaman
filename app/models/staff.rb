class Staff < SoftDeleteBaseModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_and_belongs_to_many :roles, join_table: 'staffs_roles'
  has_many :permissions, through: :roles
  has_many :organizations, through: :roles
  has_many :people, class_name: 'Person', foreign_key: 'owner_id'

  # Validations
  validates :email, :mobile_phone, presence: true

  #
  # Dynamically create instance methods to check role of staff
  #
  def has_role?(roles_arr)
    role_names = roles_arr.dup.map(&:to_s)
    (roles.pluck(:name) & role_names).size.positive?
  end

  # Get lowest organization level
  def lowest_organization
    organizations.order(level: :desc).first
  end

  # Get highest organization level
  def highest_organization
    organizations.order(level: :asc).first
  end
end
