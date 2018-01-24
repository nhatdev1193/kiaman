class StepCondition < SoftDeleteBaseModel
  belongs_to :step

  validates :condition, presence: true
end
