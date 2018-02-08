class RolePermission < SoftDeleteBaseModel

  self.table_name = 'roles_permissions'

  belongs_to :role
  belongs_to :permission
  belongs_to :organization, optional: true

end
