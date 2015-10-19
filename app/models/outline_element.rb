class OutlineElement < ActiveRecord::Base
  belongs_to :outline
  belongs_to :element
end
