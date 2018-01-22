class FormInputKind < ApplicationRecord
  acts_as_paranoid

  validates :kind, presence: true
end
