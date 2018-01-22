class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.integer :item_id, null: false
      t.string :kind, null: false
      t.text :value
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
