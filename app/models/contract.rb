class Contract < SoftDeleteBaseModel
  belongs_to :person
  belongs_to :staff
  belongs_to :contract_kind

  validates :person_id, :contract_kind_id, presence: true
end
