class AddSpecialFieldsToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :school, :string
    add_column :customers, :merchandise, :string
  end
end
