class Role < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
