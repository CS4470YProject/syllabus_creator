class Tool < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :element

  scope :insert, ->(name, element_id, faculty_id) {
    tool = Tool.new(name: name, element_id: element_id, faculty_id: faculty_id)
    if tool.save
      tool
    else
      raise 'Error creating tool'
    end
  }

  scope :remove, ->(tool_id) {
    tool = find(tool_id)
    tool.destroy
  }

  #method for retrieving a list of tools by faculty id
  scope :list_query, ->(faculty_id) {
    faculties = Faculty.arel_table
    return joins(:faculty, :element).where(faculties: {id: faculty_id})
  }

end
