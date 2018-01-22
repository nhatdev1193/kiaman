class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.references :user, foreign_key: true, null: false
      t.references :customer, foreign_key: true
      t.references :document_kind, foreign_key: true, null: false
      t.string :filename, null: false
      t.string :url, null: false
      t.string :physic_path, null: false
      t.string :content_type, null: false
      t.integer :size, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
