class Tool < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :element

  scope :search_query, ->(faculty) {
    faculties = Faculty.arel_table
    return Tool.none if faculty.blank?
    joins(:faculty, :element).where(faculties: {name: faculty})
  }

end
