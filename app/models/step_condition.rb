class StepCondition < ApplicationRecord
  acts_as_paranoid

  belongs_to :step

  validates :condition, presence: true
end
