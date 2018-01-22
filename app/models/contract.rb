class Contract < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer
  belongs_to :user
  belongs_to :contract_kind

  validates :customer_id, :user_id, :contract_kind_id, :current_workflow, :current_step, presence: true
end
