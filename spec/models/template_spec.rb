require 'rails_helper'

RSpec.describe Template, type: :model do
  describe 'Relationships' do
    it { should have_many(:outlines) }
    it { should belong_to(:category) }
  end
  describe 'Methods' do
    describe :clone do
      before :each do
        @template = FactoryGirl.create(:template)
        @course = FactoryGirl.create(:course)
        @user = FactoryGirl.create(:user)
        @element_group = FactoryGirl.create(:element_group, outline_id: @template.id)
        @element_group.elements << FactoryGirl.create(:element, text: 'element1')
        @element_group.elements << FactoryGirl.create(:element, text: 'element2')
        @senate_rule = FactoryGirl.create(:senate_rule)
      end
      it 'should create an outline from a template' do
        senate_rules = {@senate_rule.id => '1'}
        outline = @template.clone(@user, @course.code, senate_rules)
        expect(outline.course).to eq(@course)
        expect(outline.elements.size).to eq(@template.elements.size + 1)
        ol_texts = outline.elements.pluck(:text)
        tl_texts = @template.elements.pluck(:text) << @senate_rule.element.text
        expect(ol_texts).to eq(tl_texts)
      end
    end
  end
end
