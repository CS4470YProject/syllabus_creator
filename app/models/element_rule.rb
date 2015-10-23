class ElementRule < ActiveRecord::Base
  belongs_to :element
  belongs_to :rule
end
