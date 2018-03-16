class CreateFormInputConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :form_input_conditions do |t|
      t.string :condition, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
