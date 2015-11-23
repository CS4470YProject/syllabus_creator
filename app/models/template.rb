class Template < Outline

  default_scope { where(type: 'Template') }

  def set_type
    'Template'
  end
end
