class Template < Outline

  belongs_to :department
  has_many :outlines, foreign_key: 'parent_id'
  default_scope { where(type: 'Template') }

  def set_type
    'Template'
  end

  def clone(user, course_code)
    #TODO: API Call to Validate Course Code
    course = Course.where(code: course_code).first_or_create
    outline = Outline.new(user: user, course: course, parent: self)
    elements.each do |element|
      oe = outline_elements.where(element_id: element.id).first
      if element.mutable?
        new_element = element.copy_and_save
        outline.outline_elements << OutlineElement.new(element: new_element, outline: outline, order: oe.order)
      else
        outline.outline_elements << OutlineElement.new(element: element, outline: outline, order: oe.order)
      end
    end
    if outline.save
      outline
    else
      raise 'Error cloning outline'
    end
  end

  def department_name
    department.name
  end
end

