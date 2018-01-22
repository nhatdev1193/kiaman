class PermissionsRole < ApplicationRecord
  acts_as_paranoid

  belongs_to :role
  belongs_to :permission
  belongs_to :organization
end
