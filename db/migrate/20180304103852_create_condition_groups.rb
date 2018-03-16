class CreateConditionGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :condition_groups do |t|
      t.references :condition, foreign_key: true
      t.integer :parent_id
      t.string :operator

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :condition_groups, [:condition_id, :deleted_at], unique: true
  end
end