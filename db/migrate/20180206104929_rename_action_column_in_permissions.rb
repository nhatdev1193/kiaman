class RenameActionColumnInPermissions < ActiveRecord::Migration[5.1]
  def change
    rename_column :permissions, :action, :name
  end
end
