class Rule < ActiveRecord::Base
  has_many :element_rules, dependent: :destroy
end
