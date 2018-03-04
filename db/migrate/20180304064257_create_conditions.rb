class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.string :name
      t.text :condition
      t.integer :condition_kind, null: false, default: 1

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
