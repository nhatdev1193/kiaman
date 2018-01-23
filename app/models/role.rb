class Role < SoftDeleteBaseModel
  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
