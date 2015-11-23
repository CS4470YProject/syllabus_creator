require 'rails_helper'

RSpec.describe Outline, type: :model do
  describe 'Relationships' do
    it { should have_many(:outline_elements) }
    it { should have_many(:elements).through(:outline_elements) }
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end

  describe 'Scopes' do
    before(:each) do
      course = FactoryGirl.create(:course, code: 'cs1027')
      @outline1 = FactoryGirl.create(:outline)
      @outline2 = FactoryGirl.create(:outline, course: course)
    end
    describe 'recent_outlines' do
      it 'should return the most recent outlines' do
        outlines = Outline.recent_outlines(1)
        expect(outlines.size).to eq(1)
      end
    end
    describe 'search query' do
      it 'should return the searched for outline' do
        outlines = Outline.search_query('cs1')
        expect(outlines.size).to eq(1)
        expect(outlines.first.id).to eq(@outline2.id)
      end
      it 'should return nothing if given empty string' do
        outlines = Outline.search_query(' ')
        expect(outlines.size).to eq(0)
      end
    end

  end
end
