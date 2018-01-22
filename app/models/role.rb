class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
