# frozen_string_literal: true

class AddDeviseToStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
      t.string :name
      t.string :address
      t.string :phone
      t.string :mobile_phone, null: false, unique: true
      t.datetime :deleted_at

      t.references :role, foreign_key: true, null: false
      t.references :organization, foreign_key: true, null: false
    end

    add_index :staffs, :email,                unique: true
    add_index :staffs, :reset_password_token, unique: true
    add_index :staffs, [:email, :deleted_at], name: 'idx_unique_staff_email', unique: true
    add_index :staffs, [:mobile_phone, :deleted_at], name: 'idx_unique_staff_mobile_phone', unique: true
    # add_index :staffs, :confirmation_token,   unique: true
    # add_index :staffs, :unlock_token,         unique: true
  end
end
