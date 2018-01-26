class Organization < SoftDeleteBaseModel
  has_many :staffs

  validates :name, presence: true
end
