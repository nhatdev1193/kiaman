class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :role, foreign_key: true, null: false
    add_reference :users, :organization, foreign_key: true, null: false
    add_column :users, :deleted_at, :datetime
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :mobile_phone, :string, null: false, unique: true
    add_column :users, :failed_attemps, :integer, null: false, default: 0
    add_column :users, :locked_at, :datetime
    add_column :users, :unlock_token, :datetime

    add_index :users, [:email, :deleted_at], name: 'idx_unique_user_email', unique: true
    add_index :users, [:mobile_phone, :deleted_at], name: 'idx_unique_user_mobile_phone', unique: true
  end
end
