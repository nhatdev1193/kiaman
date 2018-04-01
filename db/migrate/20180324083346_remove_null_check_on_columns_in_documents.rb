class RemoveNullCheckOnColumnsInDocuments < ActiveRecord::Migration[5.1]
  def change
    change_column :documents, :filename, :text, null: true
    change_column :documents, :physic_path, :text, null: true
    change_column :documents, :url, :text, null: true
    change_column :documents, :content_type, :string, null: true
    change_column :documents, :size, :integer, null: true
  end
end
