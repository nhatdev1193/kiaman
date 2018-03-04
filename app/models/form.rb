class Form < SoftDeleteBaseModel
  has_many :steps
  has_many :form_fields
  has_many :form_values
  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
  validates :is_template, presence: true
end
