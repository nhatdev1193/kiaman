class Role < SoftDeleteBaseModel

  has_and_belongs_to_many :staffs, join_table: 'staffs_roles'
  has_many :role_permissions, class_name: RolePermission
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
