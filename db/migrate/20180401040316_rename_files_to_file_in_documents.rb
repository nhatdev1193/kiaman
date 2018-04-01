class RenameFilesToFileInDocuments < ActiveRecord::Migration[5.1]
  def change
    rename_column :documents, :files, :file
  end
end
