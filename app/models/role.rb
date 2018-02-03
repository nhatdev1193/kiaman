class Role < SoftDeleteBaseModel
  has_and_belongs_to_many :staffs, join_table: 'staffs_roles'
  has_and_belongs_to_many :permissions

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true
end
