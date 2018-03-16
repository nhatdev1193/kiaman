class Role < SoftDeleteBaseModel
  include Parentable

  # Associations
  has_and_belongs_to_many :staffs, join_table: 'staffs_roles'
  has_many :role_permissions, class_name: RolePermission
  has_many :permissions, through: :role_permissions
  belongs_to :organization

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :level, presence: true

  # Methods
  def self.search(conditions)
    query = without_admin_role

    if conditions
      query = query.where(name: conditions[:name]) if conditions[:name].present?
    end

    query.order(:level)
  end

  # Scopes
  scope :without_admin_role, -> {
    where.not(name: 'admin')
  }
end
