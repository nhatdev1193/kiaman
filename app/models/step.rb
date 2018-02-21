class Step < SoftDeleteBaseModel
  has_many :children, class_name: 'Step', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Step', optional: true
  belongs_to :service
  belongs_to :form, optional: true
  belongs_to :next_step, class_name: 'Step', foreign_key: 'next_step_id', optional: true
  belongs_to :prev_step, class_name: 'Step', foreign_key: 'prev_step_id', optional: true

  validates :name, presence: true, uniqueness: true
  validates :service, presence: true
  validate :cannot_same_step

  scope :can_become_parent, ->(current_step) {
    if current_step.id.nil?
      all
    else
      where.not(id: current_step.id)
    end
  }

  private

  # rubocop:disable all
  def cannot_same_step
    errors.add(:base, 'Parent step and next step can not be same.') if parent_id.present? && next_step_id.present? && parent_id == next_step_id
    errors.add(:base, 'Parent step and previous step can not be same.') if parent_id.present? && prev_step_id.present? && parent_id == prev_step_id
    errors.add(:base, 'Next step and previous step can not be same.') if next_step_id.present? && prev_step_id.present? && next_step_id == prev_step_id
  end
end
