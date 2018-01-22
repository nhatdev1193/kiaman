class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, unique: true, null: false
      t.text :description
      t.integer :level, null: false, default: 1
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :roles, [:name, :deleted_at], name: 'idx_unique_role_name', unique: true
  end
end
