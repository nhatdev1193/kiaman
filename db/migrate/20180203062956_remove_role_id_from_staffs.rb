class RemoveRoleIdFromStaffs < ActiveRecord::Migration[5.1]
  def change
    remove_column :staffs, :role_id
  end
end
