class Element < ActiveRecord::Base
  has_many :outline_elements, dependent: :destroy
  has_many :element_rules, dependent: :destroy
  has_many :rules, through: :element_rules

  def copy_and_save
    new_element = dup
    element_rules.each do |e_r|
      new_element.element_rules << ElementRule.new(element: new_element, rule_id: e_r.rule_id)
    end
    new_element.save
    new_element
  end

  def mutable?
    rules.where(mutable: false).size == 0
  end

end
