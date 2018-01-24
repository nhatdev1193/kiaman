class Permission < SoftDeleteBaseModel
  validates :action, :resource_type, presence: true
end
