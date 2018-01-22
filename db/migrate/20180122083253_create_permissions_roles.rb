class CreatePermissionsRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions_roles do |t|
      t.references :role, foreign_key: true, null: false
      t.references :permission, foreign_key: true, null: false

      #If this column IS NULL, this permission is applied to all organizations
      #If this column IS NOT NULL, this permission will have effect only for this organization_id
      t.references :organization, foreign_key: true, default: :null
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
