class RenamePermissionsRolesTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :permissions_roles, :roles_permissions
  end
end
