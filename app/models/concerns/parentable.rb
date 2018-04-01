module Parentable
  extend ActiveSupport::Concern

  included do
    # Associations
    has_many :children, class_name: self.name.to_s, foreign_key: 'parent_id'
    belongs_to :parent, class_name: self.name.to_s, optional: true

    # Callbacks
    before_save :set_level

    # Scopes
    scope :can_become_parent, ->(current_model) {
      if current_model.id.nil?
        all
      else
        where.not(id: current_model.id) # Not itself
             .where('level <= ?', current_model.level) # Must be at higher level
      end
    }

    # Get all children id
    def all_children(children_array = [self.id])
      children_array << self.child_ids
      self.children.each do |child|
        child.all_children(children_array)
      end
      children_array.flatten.uniq
    end
  end

  #
  # Methods defined here are going to extend the class, not the instance of it
  #
  class_methods do
  end

  # Private methods
  private

  def set_level
    self.level = parent.nil? ? 1 : parent.level + 1
  end
end
