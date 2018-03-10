class AddFieldsToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :gender, :boolean
    add_column :customers, :birthday, :date
    add_column :customers, :phone, :string
    add_column :customers, :status, :integer
  end
end
