class Service < SoftDeleteBaseModel
  validates :name, presence: true, uniqueness: true
end
