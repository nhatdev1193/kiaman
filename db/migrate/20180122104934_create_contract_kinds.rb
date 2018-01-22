class CreateContractKinds < ActiveRecord::Migration[5.1]
  def change
    create_table :contract_kinds do |t|
      t.string :name, null: false, unique: true
      t.text :description
      t.json :step_ids, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :contract_kinds, [:name, :deleted_at], name: 'idx_unique_contract_kind_name', unique: true
  end
end
