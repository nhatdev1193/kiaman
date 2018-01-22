class Permission < ApplicationRecord
  acts_as_paranoid

  has_and_belongs_to_many :roles

  validates :action, :resource_type, presence: true
end
