class FormInputCondition < ApplicationRecord
  acts_as_paranoid

  validates :condition, presence: true
end
