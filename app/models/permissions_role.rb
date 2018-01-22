class PermissionsRole < ApplicationRecord
  belongs_to :role
  belongs_to :permission
  belongs_to :organization
end
