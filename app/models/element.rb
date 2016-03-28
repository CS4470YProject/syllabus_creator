class Element < ActiveRecord::Base
  has_many :outline_elements, dependent: :destroy
  has_many :element_rules, dependent: :destroy
  has_many :rules, through: :element_rules
  has_one :header
  has_one :senate_rule
  has_one :image_attachment
  accepts_nested_attributes_for :header

  # Image uploader
  mount_uploader :image, ImageUploader

  def copy_and_save
    new_element = dup
    element_rules.each do |e_r|
      new_element.element_rules << ElementRule.new(element: new_element, rule_id: e_r.rule_id)
    end
    new_element.create_header(text: header.text,
                              size: header.size,
                              bold: header.bold,
                              italic: header.italic,
                              underline: header.underline
    ) unless header.nil?
    new_element.save
    new_element
  end

  def clone
    copy_and_save
  end

  def immutable?
    rules.where(immutable: true).size >= 1
  end

  def required?
    rules.where(required: true).size >= 1
  end

end
