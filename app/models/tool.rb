class Tool < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :element

  scope :search_query, ->(faculty_id) {
    faculties = Faculty.arel_table
    return Tool.none if faculty_id.blank?
    joins(:faculty, :element).where(faculties: {id: faculty_id})
  }

end
