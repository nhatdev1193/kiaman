class FormValue < ApplicationRecord
  belongs_to :form
  belongs_to :form_field
end