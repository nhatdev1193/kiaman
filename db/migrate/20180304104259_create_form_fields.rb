class CreateFormFields < ActiveRecord::Migration[5.1]
  def change
    create_table :form_fields do |t|
      t.references :form, foreign_key: true
      t.references :form_input, foreign_key: true
      t.references :condition_group, foreign_key: true
      t.references :form_object, foreign_key: true
      t.string :field_name
      t.integer :order

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :form_fields, [:form_id, :deleted_at], unique: true
    add_index :form_fields, [:form_input_id, :deleted_at], unique: true
    add_index :form_fields, [:condition_group_id, :deleted_at], unique: true
    add_index :form_fields, [:form_object_id, :deleted_at], unique: true
  end
end