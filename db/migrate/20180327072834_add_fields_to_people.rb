class AddFieldsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :organization_id, :integer
    add_column :people, :owner_id, :integer
  end
end
