class CreateSupportProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :support_profiles do |t|
      t.string :fullname
      t.string :relationship
      t.string :phone
      t.string :address
      t.string :job
      t.string :nic_number
      t.boolean :know_the_loan
      t.text :note
      t.references :person

      t.timestamps
    end
  end
end
