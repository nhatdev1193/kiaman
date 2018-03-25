class DocumentKind < SoftDeleteBaseModel

  # Associations
  has_many :documents

  # Validations
  validates :name, presence: true

end
