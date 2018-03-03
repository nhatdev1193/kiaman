class AddOrganizationIdToRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :organization, foreign_key: true
  end
end
