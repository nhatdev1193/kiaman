class AddNicNumberToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :nic_number, :string
  end
end
