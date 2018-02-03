class Staff < SoftDeleteBaseModel

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  has_and_belongs_to_many :roles, join_table: 'staffs_roles'
  has_many :permissions, through: :roles

  validates :email, :organization_id, :mobile_phone, presence: true

  #
  # Dynamically create instance methods to check role of staff
  #
  roles_name = Role.all.map(&:name)
  roles_name.each do |role_name|
    define_method "#{role_name}?" do
      true
      # roles.all.map(&:name).include?(role_name)
    end
  end
end
