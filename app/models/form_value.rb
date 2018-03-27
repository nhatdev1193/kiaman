class FormValue < ApplicationRecord
  belongs_to :form
  belongs_to :form_field

  validate :process_validation

  def process_validation
    condition = self.form_field&.condition_group&.condition&.condition
    value = self.value
    if condition && condition['validator'] == 'presence' && value&.empty?
      self.errors.add(self.form_field.field_name, "can't be blank")
    end
  end
end