class AddParentIdToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :parent_id, :integer
  end
end
