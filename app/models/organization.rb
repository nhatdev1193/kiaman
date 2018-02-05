class Organization < SoftDeleteBaseModel
  # Associations
  has_many :staffs
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Organization', optional: true

  # Validations
  validates :name, presence: true

  # Callbacks
  before_save :set_level

  # Scopes
  scope :can_become_parent, lambda { |current_organization|
    if current_organization.id.nil?
      all
    else
      where.not(id: current_organization.id) # Not itself
           .where('level <= ?', current_organization.level) # Must be at higher level
    end
  }

  # Private methods
  private

  def set_level
    self.level = parent.nil? ? 1 : parent.level + 1
  end
end
