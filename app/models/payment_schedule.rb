class PaymentSchedule < ApplicationRecord
  acts_as_paranoid

  belongs_to :contract

  validates :contract_id, :pay_date, :pay_amount, presence: true
end
