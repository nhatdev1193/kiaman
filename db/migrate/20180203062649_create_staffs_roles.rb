class CreateStaffsRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs_roles do |t|
      t.references :role, foreign_key: true, null: false
      t.references :staff, foreign_key: true, null: false

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
