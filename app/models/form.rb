class Form < ApplicationRecord
  acts_as_paranoid

  belongs_to :step
  belongs_to :contract_kind

  validates :name, presence: true, uniqueness: true
  validates :is_template, presence: true
end
