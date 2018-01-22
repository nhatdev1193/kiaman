class Revision < ApplicationRecord
  acts_as_paranoid

  validates :item_id, :kind, presence: true
end
