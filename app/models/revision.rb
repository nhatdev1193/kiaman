class Revision < SoftDeleteBaseModel
  validates :item_id, :kind, presence: true
end
