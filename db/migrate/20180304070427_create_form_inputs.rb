class CreateFormInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :form_inputs do |t|
      t.string :name
      t.string :render_type

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
