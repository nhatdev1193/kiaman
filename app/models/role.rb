class Role < ApplicationRecord
  acts_as_paranoid

  has_many :users
  has_and_belongs_to_many :permissions

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
