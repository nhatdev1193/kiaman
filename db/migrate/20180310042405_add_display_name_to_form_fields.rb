class AddDisplayNameToFormFields < ActiveRecord::Migration[5.1]
  def change
    add_column :form_fields, :display_name, :string
  end
end
