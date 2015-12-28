require 'rails_helper'

RSpec.describe Template, type: :model do
  describe 'Relationships' do
    it { should have_many(:outlines) }
    it { should belong_to(:department) }
  end
  describe 'Methods' do
    describe :clone do
      before :each do
        @template = FactoryGirl.create(:template)
        @course = FactoryGirl.create(:course)
        @user = FactoryGirl.create(:user)
        @template.elements << FactoryGirl.create(:element)
        @template.elements << FactoryGirl.create(:element)
      end
      it 'should create an outline from a template' do
        outline = @template.clone(@user, @course.code)
        expect(outline.course).to eq(@course)
        expect(outline.elements.size).to eq(@template.elements.size)
        element1 = @template.elements.first
        element2 = @template.elements.second
        expect(outline.elements).to include(element1)
        expect(outline.elements).to include(element2)
      end
    end
  end
end
