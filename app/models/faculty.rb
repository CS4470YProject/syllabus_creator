class Faculty < ActiveRecord::Base
  has_many :categories
  has_many :faculties
  belongs_to :parent, class_name: 'Faculty', foreign_key: :parent_id
  has_many :senate_rules
  has_many :tools, dependent: :destroy

  def senate_rules
    return  SenateRule.where(faculty_id: [id, parent_id]) if parent.present?
    SenateRule.where(faculty_id: id)
  end
end
