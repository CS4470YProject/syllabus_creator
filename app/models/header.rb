class Header < ActiveRecord::Base
  belongs_to :element
  belongs_to :element_group

  STYLE_OPTIONS = %i(bold italic underline)
  SIZE_OPTIONS = (16..36)


end
