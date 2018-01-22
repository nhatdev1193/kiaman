class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :payment_schedule, foreign_key: true, null: false
      t.float :amount, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
