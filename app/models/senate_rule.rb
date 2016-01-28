class SenateRule < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :element
end
