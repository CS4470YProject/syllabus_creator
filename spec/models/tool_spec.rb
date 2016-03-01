require 'rails_helper'

RSpec.describe Tool, type: :model do
  describe "Relationships" do
    it { should belong_to(:faculty) }
    it { should belong_to(:element) }
  end

  describe 'Scopes' do
    before(:each) do
      faculty = FactoryGirl.create(:faculty, name: 'science')
      faculty2 = FactoryGirl.create(:faculty, name: 'engineering')
      @tool = FactoryGirl.create(:tool, faculty: faculty)
      @tool2 = FactoryGirl.create(:tool, faculty: faculty)
      @tool3 = FactoryGirl.create(:tool, faculty: faculty2)
    end
    describe 'list query' do
      it 'should return the tools for the given faculty' do
        tools = Tool.list_query(1)
        expect(tools.size).to eq(2)
        tools = Tool.list_query(2)
        expect(tools.size).to eq(1)
        tools = Tool.list_query(3)
        expect(tools.size).to eq(0)
      end
      it 'should return nothing if given empty string' do
        tools = Tool.list_query(' ')
        expect(tools.size).to eq(0)
      end
    end
  end

end
