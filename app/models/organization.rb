class Organization < SoftDeleteBaseModel
  
  has_many :users
  
  validates :name, presence: true

end
