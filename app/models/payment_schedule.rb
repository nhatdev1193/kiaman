class PaymentSchedule < SoftDeleteBaseModel
  belongs_to :contract

  validates :contract_id, :pay_date, :pay_amount, presence: true
end
