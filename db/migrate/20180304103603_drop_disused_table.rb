class DropDisusedTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :form_input_conditions
    remove_index :form_input_values, name: :index_form_input_values_on_contract_id
    remove_index :form_input_values, name: :index_form_input_values_on_form_id
    remove_index :form_input_values, name: :index_form_input_values_on_form_input_kind_id
    drop_table :form_input_values, force: :cascade
    remove_index :form_input_kinds, name: :idx_unique_form_input_kind
    drop_table :form_input_kinds, force: :cascade
  end
end
