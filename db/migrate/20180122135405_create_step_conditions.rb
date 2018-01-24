class CreateStepConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :step_conditions do |t|
      t.references :step, foreign_key: true
      t.text :condition, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
