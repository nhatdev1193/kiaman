class ConditionGroup < ApplicationRecord
  belongs_to :condition
  has_many :form_fields
end
