class RemoveResourceTypeColumnInPermissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :permissions, :resource_type
  end
end
