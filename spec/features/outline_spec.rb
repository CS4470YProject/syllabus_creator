require 'rails_helper'

feature 'Outline' do
  describe 'Searching by course code' do
    before(:each) do
      @outline = FactoryGirl.create(:outline)
    end
    scenario 'searching for an outline by code' do
      visit search_outlines_path
      fill_in('search-page-search', with: 'cs')
      find_by_id('search-page-submit').click
      expect(page).to have_content @outline.course.code

      fill_in('search-page-search', with: 'asdad')
      find_by_id('search-page-submit').click
      expect(page).to have_content 'No results found for asdad'
    end
  end

  describe 'Outlines Index Page' do
    before(:each) do
      @outline = FactoryGirl.create(:outline)
    end
    scenario 'viewing outlines' do
      visit outlines_path
      expect(page).to have_selector(:button, @outline.course.code)
    end
  end
end