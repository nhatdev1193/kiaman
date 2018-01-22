class Transaction < ApplicationRecord
  acts_as_paranoid

  belongs_to :payment_schedule

  validates :payment_schedule_id, :amount, presence: true
end
