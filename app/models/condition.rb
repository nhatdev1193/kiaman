class Condition < ApplicationRecord
  has_many :condition_groups
  enum condition_kind: { step_access: 1, step_change: 2, form_input: 3 }
end