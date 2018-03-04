class CreateFormObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :form_objects do |t|
      t.string :name

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
