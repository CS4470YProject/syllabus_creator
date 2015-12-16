class Template < Outline

  default_scope { where(type: 'Template') }

  def set_type
    'Template'
  end

  def clone(user, course_code)
    #TODO: API Call to Validate Course Code
    course = Course.where(code: course_code).first_or_create
    outline = Outline.new(user: user, course: course)
    elements.each do |element|
      oe = outline_elements.where(element_id: element.id).first
      outline.outline_elements << OutlineElement.new(element: element, outline: outline, order: oe.order)
    end
    if outline.save?
      outline
    else
      raise 'Error cloning outline'
    end
  end
end

