class Step < ApplicationRecord
  acts_as_paranoid

  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
end
