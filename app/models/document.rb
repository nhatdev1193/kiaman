class Document < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :customer
  belongs_to :document_kind

  validates :user_id, :document_kind_id, :filename, :url, :physic_path, :content_type, :size, presence: true
end
