class OutlineElement < ActiveRecord::Base
  belongs_to :outline
  belongs_to :element

  scope :outlines_for_element, -> (element_id) { where(element_id: element_id) }

  accepts_nested_attributes_for :element
end
