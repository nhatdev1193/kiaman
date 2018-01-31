class StaffBase < SoftDeleteBaseModel
  self.abstract_class = true

  attr_reader :role_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  belongs_to :role
  has_many :permissions, through: :role

  validates :email, :role_id, :organization_id, :mobile_phone, presence: true

  def role_name
    role.name
  end

  def admin?
    role.name == 'admin'
  end


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    role_name = conditions[:params].fetch(:role_name).downcase
    conditions.delete(:params)
    where(conditions.to_h)
      .joins(:role).where('roles.name = ?', role_name)
      .first
  end
end
