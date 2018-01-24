class DocumentKind < SoftDeleteBaseModel
  validates :name, presence: true
end
