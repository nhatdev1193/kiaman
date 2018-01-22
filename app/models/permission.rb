class Permission < ApplicationRecord
  acts_as_paranoid

  validates :action, :resource_type, presence: true
end
