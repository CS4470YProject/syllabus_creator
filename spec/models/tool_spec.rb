require 'rails_helper'

RSpec.describe Tool, type: :model do
  describe "Relationships" do
    it { should belong_to(:faculty) }
    it { should belong_to(:element) }
  end

  describe 'Scopes' do
    before(:each) do
      @element = FactoryGirl.create(:element, text: "new element")
      @faculty = FactoryGirl.create(:faculty, name: 'science')
      @faculty2 = FactoryGirl.create(:faculty, name: 'engineering')
      @faculty3 = FactoryGirl.create(:faculty, name: 'biology')
      @tool = FactoryGirl.create(:tool, faculty: @faculty)
      @tool2 = FactoryGirl.create(:tool, faculty: @faculty)
      @tool3 = FactoryGirl.create(:tool, faculty: @faculty2, element: @element)
    end
    describe 'list query' do
      it 'should return the tools for the given faculty' do
        tools = Tool.list_query(@faculty.id)
        expect(tools.size).to eq(2)
        tools = Tool.list_query(@faculty2.id)
        expect(tools.size).to eq(1)
        tools = Tool.list_query(-1)
        expect(tools.size).to eq(0)
      end
    end
    describe 'insert' do
      it 'should add a new tool to the database' do
        newTool = Tool.insert('insertTest', @element.id, @faculty3.id)
        expect(Tool.where(name: "insertTest", element_id: @element.id,
                          faculty_id: @faculty3.id)).to exist
      end
    end
    describe 'remove' do
      it 'should remove the specified tool from the database' do
        Tool.remove(@tool3.id)
        expect(Tool.where(name: "Test Tool", element_id: @element.id,
                          faculty_id: @faculty2.id)).not_to exist
      end
    end
  end

end
