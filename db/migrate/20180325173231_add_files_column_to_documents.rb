class AddFilesColumnToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :files, :text
  end
end
