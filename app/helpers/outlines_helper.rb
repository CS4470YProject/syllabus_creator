module OutlinesHelper

  def get_senate_rules(template)
    faculty = template.faculty
    faculty.senate_rules
  end

  def header_class(header)
    klass = ''
    klass += 'bold ' if header.bold
    klass += 'italic ' if header.italic
    klass += 'underline ' if header.underline
    klass += "font-#{header.size}" if header.size
    klass
  end

end
