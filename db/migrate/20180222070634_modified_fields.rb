class ModifiedFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :contract_kinds, :step_ids
    remove_column :contracts, :staff_id
    remove_column :contracts, :current_workflow
    remove_column :contracts, :current_step

    remove_column :customers_steps, :approved_at
    remove_column :customers_steps, :rejected_at
    remove_foreign_key :customers_steps, :staffs
    remove_column :customers_steps, :staff_id
    remove_foreign_key :customers_steps, :contracts
    remove_column :customers_steps, :contract_id

    add_column :customers_steps, :created_staff_id, :integer
    add_column :customers_steps, :assigned_staff_id, :integer
    add_column :customers_steps, :status, :integer
    add_column :customers_steps, :assigned_at, :datetime
    add_reference :customers_steps, :contract, foreign_key: true
  end
end
