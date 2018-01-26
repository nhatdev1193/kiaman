class CustomersStep < SoftDeleteBaseModel
  belongs_to :step
  belongs_to :customer
  belongs_to :contract
  belongs_to :staff

  validates :step_id, :customer_id, :contract_id, :staff_id, presence: true
end
