class RenameCustomerToPerson < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :contracts, :customers
    remove_column :contracts, :customer_id
    remove_foreign_key :customers_steps, :customers
    remove_column :customers_steps, :customer_id
    remove_foreign_key :documents, :customers
    remove_column :documents, :customer_id

    remove_foreign_key :customers_steps, :contracts
    remove_column :customers_steps, :contract_id
    remove_foreign_key :customers_steps, :steps
    remove_column :customers_steps, :step_id

    rename_table :customers, :people
    rename_table :customers_steps, :people_steps

    add_reference :contracts, :person, foreign_key: true
    add_reference :documents, :person, foreign_key: true
    add_reference :people_steps, :person, foreign_key: true
    add_reference :people_steps, :contract, foreign_key: true
    add_reference :people_steps, :step, foreign_key: true
  end
end
