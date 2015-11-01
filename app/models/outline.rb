class Outline < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :outline_elements
  has_many :elements, through: :outline_elements
end
