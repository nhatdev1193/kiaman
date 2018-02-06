class Permission < SoftDeleteBaseModel

  has_and_belongs_to_many :roles

  validates :name, presence: true

end
