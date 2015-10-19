class Outline < ActiveRecord::Base
  belongs_to :user
  has_many :outline_elements
  has_many :elements, through: :outline_elements
end
