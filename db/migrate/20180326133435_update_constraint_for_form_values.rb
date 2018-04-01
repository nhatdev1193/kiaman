class UpdateConstraintForFormValues < ActiveRecord::Migration[5.1]
  def change
    remove_index :form_values, [:form_id, :deleted_at]
    remove_index :form_values, [:form_field_id, :deleted_at]
  end
end
