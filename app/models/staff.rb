class Staff < SoftDeleteBaseModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  has_and_belongs_to_many :roles, join_table: 'staffs_roles'
  has_many :permissions, through: :roles

  validates :email, :organization_id, :mobile_phone, :roles, presence: true

  #
  # Dynamically create instance methods to check role of staff
  #
  def has_role?(roles_arr)
    role_names = roles_arr.dup.map(&:to_s)
    (roles.pluck(:name) & role_names).size.positive?
  end
end
