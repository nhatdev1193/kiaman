class DocumentKind < SoftDeleteBaseModel

  # Associations
  has_many :documents

  # Validations
  validates :field_name, :display_name, presence: true

end
