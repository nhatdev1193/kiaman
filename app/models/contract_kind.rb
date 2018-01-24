class ContractKind < SoftDeleteBaseModel
  validates :name, :step_ids, presence: true
end
