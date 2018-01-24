class Form < SoftDeleteBaseModel
  belongs_to :step
  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
  validates :is_template, presence: true
end
