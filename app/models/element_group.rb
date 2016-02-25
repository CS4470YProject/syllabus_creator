class ElementGroup < ActiveRecord::Base
  has_many :elements, -> { order(rank: :asc) }, dependent: :destroy
  has_one :header
  belongs_to :outline

  accepts_nested_attributes_for :elements, allow_destroy: true

  before_create :set_rank

  def clone
    new_element_group = dup
    elements.each do |element|
      new_element_group.elements << element.clone
    end
    new_element_group.create_header(text: header.text,
                                    size: header.size,
                                    bold: header.bold,
                                    italic: header.italic,
                                    underline: header.underline
    ) unless header.nil?
    new_element_group
  end


  private

  def set_rank
    self.rank = ElementGroup.where(outline_id: outline_id).size if rank.nil?
  end

end
