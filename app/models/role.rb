class Role < SoftDeleteBaseModel
  has_many :staffs
  has_and_belongs_to_many :permissions

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
