class Tool < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :element

  #method for retrieving a list of tools by faculty id
  scope :list_query, ->(faculty_id) {
    faculties = Faculty.arel_table
    return joins(:faculty, :element).where(faculties: {id: faculty_id})
  }

end
