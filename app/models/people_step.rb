class PeopleStep < SoftDeleteBaseModel
  include AASM

  belongs_to :step
  belongs_to :person
  belongs_to :contract, optional: true
  belongs_to :created_staff, class_name: 'Staff', foreign_key: 'created_staff_id'
  belongs_to :assigned_staff, class_name: 'Staff', foreign_key: 'assigned_staff_id'

  validates :step_id, :person_id, presence: true

  enum status: { not_started: 0, in_progress: 1, done: 2, waiting: 3,
                 error: 4, canceled: 5, skipped: 6, rollback: 7 }

  aasm column: :status, enum: true, whiny_transitions: false do
    state :not_started, initial: true
    state :in_progress
    state :done
    state :waiting
    state :error
    state :canceled
    state :skipped
    state :rollback

    event :next_step, after_commit: :next_step_for_person do
      # TODO: need to check from conditions table
      return unless true
      transitions from: [:not_started, :in_progress, :waiting], to: :done, unless: :if_done?
    end

    event :previous_step, after_commit: :previous_step_for_person do
      # TODO: need to check from conditions table
      return unless true
      transitions from: [:not_started, :in_progress, :waiting], to: :rollback, unless: :if_rollback?
    end

    event :end_step do
      transitions to: :done
    end
  end

  def product_name
    step.product.name
  end

  private

  def next_step_for_person(current_staff_id)
    return unless step.next_step
    new_person_step(step.next_step, person, current_staff_id)
  end

  def previous_step_for_person(current_staff_id)
    return unless step.prev_step
    new_person_step(step.prev_step, person, current_staff_id)
  end

  def if_done?
    status.to_sym == :done
  end

  def if_rollback?
    status.to_sym == :rollback
  end

  def new_person_step(step, person, current_staff_id)
    PeopleStep.create step: step, person: person, created_staff_id: current_staff_id, assigned_staff_id: current_staff_id, assigned_at: Time.now
  end
end
