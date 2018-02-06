class AddFieldsToStep < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :parent_id, :integer
    add_reference :steps, :service, foreign_key: true
    add_column :steps, :next_step_id, :integer
    add_reference :steps, :form, foreign_key: true

    remove_foreign_key :steps, :contract_kinds
    remove_column :steps, :contract_kind_id
  end
end
