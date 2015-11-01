class Element < ActiveRecord::Base
  has_many :outline_elements
  has_many :element_rules
  has_many :rules, through: :element_rules

end
