class StaffBase < SoftDeleteBaseModel
  self.abstract_class = true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  belongs_to :role
  has_many :permissions, through: :role

  validates :email, :role_id, :organization_id, :mobile_phone, presence: true

  def admin?
    role.name == 'admin'
  end
end
