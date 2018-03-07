class Product < SoftDeleteBaseModel
  has_many :steps

  validates :name, presence: true, uniqueness: true

  def first_step
    steps.find_by(prev_step_id: nil)
  end
end
