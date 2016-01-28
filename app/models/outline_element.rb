class OutlineElement < ActiveRecord::Base
  belongs_to :outline
  belongs_to :element

  scope :outlines_for_element, -> (element_id) { where(element_id: element_id) }
  scope :for_outline_and_element, -> (outline, element) { where(outline_id: outline.id, element_id: element.id) }

  accepts_nested_attributes_for :element

  after_destroy :remove_detached_elements
  before_create :set_order

  private

  def remove_detached_elements
    if OutlineElement.where(element_id: element_id).size == 0
      Element.where(id: element_id).first.try(:destroy)
    end
  end

  def set_order
    self.order = OutlineElement.where(outline_id: outline_id).size if order.nil?
  end
end
