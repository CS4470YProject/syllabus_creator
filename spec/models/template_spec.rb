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
        @template.elements << FactoryGirl.create(:element)
        @template.elements << FactoryGirl.create(:element)
        @senate_rule = FactoryGirl.create(:senate_rule)
      end
      it 'should create an outline from a template' do
        senate_rules = {@senate_rule.id => '1'}
        outline = @template.clone(@user, @course.code, senate_rules)
        expect(outline.course).to eq(@course)
        expect(outline.elements.size).to eq(@template.elements.size + 1)
        element1 = @template.elements.first
        element2 = @template.elements.second
        expect(outline.elements).to include(element1)
        expect(outline.elements).to include(element2)
        expect(outline.elements).to include(@senate_rule.element)
      end
    end
  end
end
