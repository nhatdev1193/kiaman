class CreateFormValues < ActiveRecord::Migration[5.1]
  def change
    create_table :form_values do |t|
      t.references :form, foreign_key: true
      t.references :form_field, foreign_key: true
      t.integer :object_id
      t.string :value

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :form_values, [:form_id, :deleted_at], unique: true
    add_index :form_values, [:form_field_id, :deleted_at], unique: true
  end
end
