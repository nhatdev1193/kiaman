class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.integer :prev_step_id
      t.references :contract_kind, foreign_key: true
      t.string :name, null: false, unique: true
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :steps, [:name, :contract_kind_id, :deleted_at], name: 'idx_unique_step_name', unique: true
  end
end
