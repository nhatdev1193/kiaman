class CreateDocumentKinds < ActiveRecord::Migration[5.1]
  def change
    create_table :document_kinds do |t|
      t.string :name, null: false, unique: true
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :document_kinds, [:name, :deleted_at], name: 'idx_unique_document_kind_name', unique: true
  end
end
