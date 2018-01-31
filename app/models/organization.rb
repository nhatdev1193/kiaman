class Organization < SoftDeleteBaseModel
  has_many :staffs
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Organization'

  validates :name, presence: true
end
