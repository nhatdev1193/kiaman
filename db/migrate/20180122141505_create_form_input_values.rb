class CreateFormInputValues < ActiveRecord::Migration[5.1]
  def change
    create_table :form_input_values do |t|
      t.references :contract, foreign_key: true, null: false
      t.references :form, foreign_key: true, null: false
      t.references :form_input_kind, foreign_key: true, null: false
      t.json :form_input_condition_ids, null: false
      t.datetime :deleted_at
      t.string :value

      t.timestamps
    end
  end
end
