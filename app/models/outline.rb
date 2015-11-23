class Outline < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :outline_elements
  has_many :elements, through: :outline_elements

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
end
