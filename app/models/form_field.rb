class FormField < ApplicationRecord
  belongs_to :form
  belongs_to :form_input
  belongs_to :condition_group
  belongs_to :form_object
  has_many :form_values
end