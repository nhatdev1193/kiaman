class FormField < ApplicationRecord
  belongs_to :form
  belongs_to :form_input
  belongs_to :condition_group, optional: true
  belongs_to :form_object, optional: true
  has_many :form_values
end