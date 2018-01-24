class FormInputCondition < SoftDeleteBaseModel
  validates :condition, presence: true
end
