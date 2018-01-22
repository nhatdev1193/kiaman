class CreateCustomersSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :customers_steps do |t|
      t.references :step, foreign_key: true, null: false
      t.references :customer, foreign_key: true, null: false
      t.references :contract, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.datetime :deleted_at
      t.datetime :approved_at
      t.datetime :rejected_at

      t.timestamps
    end
  end
end
