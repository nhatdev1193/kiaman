class Step < SoftDeleteBaseModel
  has_many :children, class_name: 'Step', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Step', optional: true
  belongs_to :service
  belongs_to :form, optional: true
  belongs_to :next_step, class_name: 'Step', foreign_key: 'next_step_id', optional: true
  belongs_to :prev_step, class_name: 'Step', foreign_key: 'prev_step_id', optional: true

  validates :name, presence: true, uniqueness: true
  validates :service, presence: true

  scope :can_become_parent, ->(current_step) {
    if current_step.id.nil?
      all
    else
      where.not(id: current_step.id)
    end
  }
end
