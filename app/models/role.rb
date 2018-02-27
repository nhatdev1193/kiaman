class Role < SoftDeleteBaseModel

  has_and_belongs_to_many :staffs, join_table: 'staffs_roles'
  has_many :role_permissions, class_name: RolePermission
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true

  def self.search(conditions)
    query = where.not(name: 'admin')

    if conditions
      query = query.where(name: conditions[:name]) if conditions[:name].present?
    end

    query.order(:level)
  end
end
