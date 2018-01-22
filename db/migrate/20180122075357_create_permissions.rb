class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string :action, null: false #List of action constants (CREATE, READ, UPDATE, DELETE, APPROVE, REJECT)... and more can be add if require
      t.text :description
      t.string :resource_type, null: false #Model classname. Ex: User, Form ...
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :permissions, [:action, :resource_type, :deleted_at], name: 'idx_unique_action', unique: true
  end
end
