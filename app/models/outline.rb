class Outline < ActiveRecord::Base

  before_save :set_type
  before_destroy :destroy_elements
  belongs_to :user
  belongs_to :course
  belongs_to :parent, class_name: 'Template'
  # has_many :outline_elements, -> { order(order: :asc )}, dependent: :destroy
  # has_many :elements, through: :outline_elements
  has_many :element_groups, -> { order(rank: :asc)}, dependent: :destroy
  has_many :elements, through: :element_groups
  has_many :senate_rules, through: :elements

  default_scope { where(type: 'Outline') }
  #accepts_nested_attributes_for :outline_elements, allow_destroy: true
  accepts_nested_attributes_for :element_groups, allow_destroy: true

  scope :sorted_by, -> (sort_option) {
                    # extract the sort direction from the param value.
                    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
                    case sort_option.to_s
                      when /^created_at_/
                        order("outlines.created_at #{ direction }")
                      when /^code_/
                        joins(:course).order("courses.code #{direction}")
                      else
                        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
                    end
                  }



  scope :search_query, ->(code) {
    courses = Course.arel_table
    return Outline.none if code.blank?
    joins(:course).where(courses[:code].matches("%#{code}%"))
  }

  scope :recent_outlines, ->(num_outlines) {
    order(created_at: :desc).limit(num_outlines)
  }

  scope :outlines_only, -> {
    where(type: 'Outline')
  }

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [ :search_query, :sorted_by ]
  )
  def self.options_for_sorted_by
    [
        ['Course Code (a-z)', 'code_asc'],
        ['Creation date (newest first)', 'created_at_desc'],
        ['Creation date (oldest first)', 'created_at_asc'],
    ]
  end

  def code
    course.code
  end

  def set_type
    self.type = 'Outline'
  end

  def add_element(order, element_type = 'text')
    #TODO: Support for other element types
    element = Element.new
    outline_elements << OutlineElement.new(outline_id: id, element: element)
    save!
    element
  end

  def add_existing_element(element_id, element_rank, group_rank)
    element = Element.find(element_id).clone
    group = nil
    if group_rank.blank?
      group = ElementGroup.create(rank: element_rank, outline: Outline.find(id))
    else
      group = ElementGroup.where(outline_id: id, rank: group_rank).first
      element.rank = element_rank
    end
    group.elements << element
    element
  end

  def destroy_elements
    elements.each do |ele|
      ele.destroy if ele.outline_elements.size <= 1
    end
  end

  def add_tool_and_element(header, outline_content, tool_name )
    header = Header.new if header.nil?
    element = Element.create(text: outline_content, rank: -1)
    element.create_header(text: header[:text],
                          size: header[:size],
                          bold: header[:bold],
                          italic: header[:italic],
                          underline: header[:underline]
    )

    Tool.insert(tool_name, element.id, parent.category.faculty.id)
  end

end
