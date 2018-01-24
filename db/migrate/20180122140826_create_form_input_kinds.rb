class CreateFormInputKinds < ActiveRecord::Migration[5.1]
  def change
    create_table :form_input_kinds do |t|
      t.string :kind, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :form_input_kinds, [:kind, :deleted_at], name: 'idx_unique_form_input_kind', unique: true
  end
end
