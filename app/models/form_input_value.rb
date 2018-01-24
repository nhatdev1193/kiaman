class FormInputValue < SoftDeleteBaseModel
  belongs_to :contract
  belongs_to :form
  belongs_to :form_input_kind

  validates :contract_id, :form_id, :form_input_kind_id, :form_input_condition_ids, presence: true
end
