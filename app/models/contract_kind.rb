class ContractKind < SoftDeleteBaseModel
  validates :name, presence: true
end
