class Product < SoftDeleteBaseModel
  has_many :steps

  validates :name, presence: true, uniqueness: true
end
