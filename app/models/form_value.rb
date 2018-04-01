class FormValue < ApplicationRecord
  belongs_to :form
  belongs_to :form_field

  validate :process_validation

  def process_validation
    condition = self.form_field&.condition_group&.condition&.condition
    value = self.value
    if condition && condition['validator'] == 'presence' && value&.empty?
      self.errors.add(self.form_field.field_name, "là bắt buộc")
    end
  end

  def self.institution_value_empty?(form_id, number, person_id)
    field_names = FormField::INSTITUTION_FIELDS.map { |field_name| "#{field_name}_#{number}" }
    form_field_ids = FormField.where(field_name: field_names, form_id: form_id).ids
    field_values = FormValue.where(form_id: form_id, object_id: person_id, form_field_id: form_field_ids)
    field_values.pluck(:value).reject(&:empty?).empty? ? 'hidden' : 'show'
  end
end