class ModifiedSchema < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :documents, :users
    remove_column :documents, :user_id
    add_reference :documents, :staff, foreign_key: true, null: false

    remove_foreign_key :contracts, :users
    remove_column :contracts, :user_id
    add_reference :contracts, :staff, foreign_key: true, null: false

    remove_foreign_key :customers_steps, :users
    remove_column :customers_steps, :user_id
    add_reference :customers_steps, :staff, foreign_key: true, null: false

    drop_table :users
  end
end
