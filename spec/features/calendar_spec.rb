require 'rails_helper'
  describe 'Scopes' do
    before(:each) do
      @subject = "COMPSCI"
      @career = "UGRD"
      @catalogNumber = "1011B"
    end
    describe 'getCourses' do
      it 'should return a course hash for CS1011B' do
        result = Calendar.getCourses(@subject, @catalogNumber, @career)
        expect(result[0]["SUBJECT"]).to eq(@subject)
      end
    end
end
