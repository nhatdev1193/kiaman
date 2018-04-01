class Document < SoftDeleteBaseModel

  # Carrierwave uploader
  mount_uploader :file, DocumentUploader

  # Associations
  belongs_to :staff
  belongs_to :document_kind
  belongs_to :person, optional: true

  # Validations
  # validates :staff_id, :document_kind_id, :filename, :url, :physic_path, :content_type, :size, presence: true
end
