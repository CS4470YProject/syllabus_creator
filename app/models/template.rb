class Template < Outline

  belongs_to :category
  has_many :outlines, foreign_key: 'parent_id'
  default_scope { where(type: 'Template') }

  validates_presence_of :category

  def set_type
    'Template'
  end

  def clone(user, course_code, senate_rules)
    #TODO: API Call to Validate Course Code
    course = Course.where(code: course_code).first_or_create
    outline = Outline.new(user: user, course: course, parent: self)
   # senate_rules = collect_senate_rules(senate_rules)
    outline = insert_elements(outline)
    if outline.save
      outline
    else
      raise 'Error cloning outline'
    end
  end


  def department_name
    category.name
  end

  def faculty
    category.faculty
  end

  private

  def collect_senate_rules(rules)
    ids = rules.collect { |id, v| id if v == '1' }.compact
    SenateRule.where(id: ids)
  end

  # def insert_elements(outline, senate_rules)
  #   ids = elements.pluck(:id) + senate_rules.pluck(:element_id)
  #   ids.uniq!
  #   highest_rank = 0
  #   outline_elements.each do |outline_element|
  #     highest_rank = outline_element.order + 1
  #     ids.delete(outline_element.element_id)
  #     element = outline_element.element
  #     if element.immutable?
  #       new_element = element.copy_and_save
  #       outline.outline_elements << OutlineElement.new(element: new_element, outline: outline, order: outline_element.order)
  #     else
  #       outline.outline_elements << OutlineElement.new(element: element, outline: outline, order: outline_element.order)
  #     end
  #   end
  #   # put the remaining elements at the end
  #   Element.where(id: ids).each do |element|
  #     outline.outline_elements << OutlineElement.new(element: element, outline: outline, order: highest_rank)
  #     highest_rank += 1
  #   end
  #   outline
  # end

  def insert_elements(outline)
    element_groups.each do |element_group|
      outline.element_groups << element_group.clone
    end
    outline
  end

  def insert_senate_rules(outline, senate_rules)

  end

end

