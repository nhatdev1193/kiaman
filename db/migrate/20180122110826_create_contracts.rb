class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.references :contract_kind, foreign_key: true, null: false
      t.string :current_workflow, null: false
      t.string :current_step, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
