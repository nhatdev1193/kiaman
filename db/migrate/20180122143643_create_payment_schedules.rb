class CreatePaymentSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_schedules do |t|
      t.references :contract, foreign_key: true, null: false
      t.datetime :pay_date, null: false
      t.float :pay_amount, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
