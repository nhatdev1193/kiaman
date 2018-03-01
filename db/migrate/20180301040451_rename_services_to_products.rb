class RenameServicesToProducts < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :steps, :services
    remove_column :steps, :service_id
    rename_table :services, :products
    add_reference :steps, :product, foreign_key: true
  end
end
