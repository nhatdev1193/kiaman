class Form < SoftDeleteBaseModel
  has_many :steps
  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
  validates :is_template, presence: true
end
