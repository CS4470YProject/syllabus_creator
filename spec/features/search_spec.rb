require 'rails_helper'

feature 'Search' do
  describe 'Searching by course code' do
    before(:each) do
      @outline = FactoryGirl.create(:outline, course: FactoryGirl.create(:course))
    end
    scenario 'searching for an outline by code' do
      visit root_path
      fill_in('nav-search', with: 'cs')
      find_by_id('nav-submit').click
      expect(page).to have_content @outline.course.code

      fill_in('nav-search', with: 'asdad')
      find_by_id('nav-submit').click
      expect(page).to have_content 'No results found for asdad'
    end
  end
end