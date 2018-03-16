class Document < SoftDeleteBaseModel
  belongs_to :staff
  belongs_to :person
  belongs_to :document_kind

  validates :staff_id, :document_kind_id, :filename, :url, :physic_path, :content_type, :size, presence: true
end
