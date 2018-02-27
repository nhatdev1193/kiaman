class Permission < SoftDeleteBaseModel

  has_many :role_permissions, class_name: RolePermission
  has_many :roles, through: :role_permissions

  validates :name, presence: true

end
