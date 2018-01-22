class ContractKind < ApplicationRecord
  acts_as_paranoid

  validates :name, :step_ids, presence: true
end
