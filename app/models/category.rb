class Category < ActiveRecord::Base
  belongs_to :faculty
  has_many :templates
  validates_presence_of :faculty
end
