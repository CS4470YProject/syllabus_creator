require 'rails_helper'

RSpec.describe Outline, type: :model do
  describe 'Relationships' do
    it { should have_many(:outline_elements) }
    it { should have_many(:elements).through(:outline_elements) }
    it { should belong_to(:user) }
    it { should belong_to(:course) }
    it { should belong_to(:parent)}
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

  describe 'Tools' do
    describe 'tool creation' do
      before(:each) do
        course = FactoryGirl.create(:course, code: 'cs1027')
        @faculty = FactoryGirl.create(:faculty, name: 'science')
        category = FactoryGirl.create(:category, faculty: @faculty)
        template = FactoryGirl.create(:template, category: category)
        @outline = FactoryGirl.create(:outline, course: course, parent: template)
      end

      it 'should create a new element and tool correctly' do
        tool_name = 'test_tool'
        outline_content = 'test content'
        header = FactoryGirl.create(:header)
        tool = @outline.add_tool_and_element(header, outline_content, tool_name)

        expect(tool.name).to eq(tool_name)
        expect(tool.faculty_id).to eq(@faculty.id)
        element = Element.find(tool.element_id)
        expect(element.header.text).to eq(header.text)
        expect(element.header.size).to eq(header.size)
        expect(element.header.bold).to eq(header.bold)
        expect(element.header.italic).to eq(header.italic)
        expect(element.header.underline).to eq(header.underline)
      end
    end
  end
end
