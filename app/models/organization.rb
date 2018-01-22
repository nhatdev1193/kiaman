class Organization < ApplicationRecord
  acts_as_paranoid

  has_many :users

  validates :name, presence: true
end
