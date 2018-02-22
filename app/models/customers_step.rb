class CustomersStep < SoftDeleteBaseModel
  include AASM

  belongs_to :step
  belongs_to :customer
  belongs_to :contract, optional: true

  validates :step_id, :customer_id, presence: true

  enum status: { not_started: 0, in_progress: 1, done: 2, waiting: 3,
                 error: 4, canceled: 5, skipped: 6, rollback: 7 }

  aasm column: :status, enum: true do
    state :not_started, initial: true
    state :in_progress
    state :done
    state :waiting
    state :error
    state :canceled
    state :skipped
    state :rollback

    event :next_step, after_commit: :next_step_for_customer do
      # TODO: need to check from conditions table
      return unless true
      transitions to: :done
    end
  end

  private

  def next_step_for_customer
    return if status.to_sym == :done
    CustomersStep.create step: step.next_step, customer: customer
  end

  def previous_step
    # TODO: need to check from conditions table
  end

  def end_step
    # TODO: need to check from conditions table
  end
end
