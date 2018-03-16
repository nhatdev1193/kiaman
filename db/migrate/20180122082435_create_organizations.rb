class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.integer :parent_id
      t.integer :level, default: ''
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
