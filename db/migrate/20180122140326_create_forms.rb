class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.references :step, foreign_key: true
      t.references :contract_kind, foreign_key: true
      t.string :name, null: false, unique: true
      t.boolean :is_template, null: false, default: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :forms, [:name, :deleted_at], name: 'idx_unique_form_name', unique: true
  end
end
