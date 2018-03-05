class ConditionGroup < ApplicationRecord
  belongs_to :condition, optional: true
  has_many :form_fields
end
