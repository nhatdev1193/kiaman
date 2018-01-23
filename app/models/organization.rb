class Organization < SoftDeleteBaseModel
  validates :name, presence: true
end
