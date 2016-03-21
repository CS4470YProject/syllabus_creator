class Header < ActiveRecord::Base
  belongs_to :element
  belongs_to :element_group

  STYLE_OPTIONS = %i(bold italic underline)
  SIZE_OPTIONS = %i(16 24 30 36)

  def self.select_options
    [['Small', 16],['Medium', 24], ['Large', 30], ['Extra large', 36]]
  end


end
