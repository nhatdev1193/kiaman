class Contract < SoftDeleteBaseModel
  belongs_to :customer
  belongs_to :staff
  belongs_to :contract_kind

  validates :customer_id, :contract_kind_id, presence: true
end
