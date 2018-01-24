class Permission < SoftDeleteBaseModel

  has_and_belongs_to_many :roles

  validates :action, :resource_type, presence: true

end
