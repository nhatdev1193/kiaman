class CreatePermissionsRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions_roles do |t|
      t.references :role, foreign_key: true, null: false
      t.references :permission, foreign_key: true, null: false
      t.references :organization, foreign_key: true, default: :null
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
