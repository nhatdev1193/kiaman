class RemoveOrganizationIdFromStaffs < ActiveRecord::Migration[5.1]
  def change
    remove_index :staffs, :organization_id
    remove_reference :staffs, :organization
  end
end
