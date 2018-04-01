class AddFieldNameForDocumentKinds < ActiveRecord::Migration[5.1]
  def change
    rename_column :document_kinds, :name, :display_name
    rename_column :document_kinds, :description, :field_name
    change_column :document_kinds, :field_name, :string, null: false
  end
end
