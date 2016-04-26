class Header < ActiveRecord::Base
  belongs_to :element
  belongs_to :element_group

  STYLE_OPTIONS = %i(bold italic underline)
  SIZE_OPTIONS = %i(16 24 30 36)

  def self.select_options
    [['Small', 16, {class: 'font-16'}],['Medium', 24, {class: 'font-24'}], ['Large', 30, {class: 'font-30'}], ['Extra large', 36, {class: 'font-36'}]]
  end


end
