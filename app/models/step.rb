class Step < SoftDeleteBaseModel
  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
end
