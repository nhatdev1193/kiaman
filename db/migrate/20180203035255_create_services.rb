class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name, null: false, unique: true
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
