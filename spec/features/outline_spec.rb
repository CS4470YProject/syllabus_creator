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
      course = FactoryGirl.create(:course, code: 'cs1027')
      @outline = FactoryGirl.create(:outline)
      @outline2 = FactoryGirl.create(:outline, course: course, created_at: 1.week.from_now)
    end
    scenario 'viewing outlines' do
      visit outlines_path
      expect(page).to have_selector(:button, @outline.course.code)
    end
    scenario 'filtering' do
      visit outlines_path
      fill_in('filter-search', with: @outline2.code)
      find_by_id('filter-submit').click
      filter_div = find_by_id('filter-div')
      expect(filter_div).to have_content(@outline2.code)
      expect(filter_div).to_not have_content(@outline.code)
    end
  end

  describe 'Creating a new outline as an instructor', js:true do
    before(:each) do
      @template = FactoryGirl.create(:template)
      @user  = FactoryGirl.create(:user, :instructor)
      category = @template.category
      faculty = category.faculty
      @senate_rule = FactoryGirl.create(:senate_rule, faculty: faculty)
      visit root_path
      find_by_id('login-link').click
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'password')
      find_by_id('login-button').click
    end
    scenario 'creating an outline with valid information' do
      click_button 'Create New Outline'
      fill_in('course_course_code', with: 'cs4470')
      select_from_chosen(@template.department_name, from: 'outline_parent_id')
      click_button 'Create Outline'
      expect(page).to have_content(@senate_rule.description)
      click_button 'Continue'
      expect(page).to have_content('Processing')
      expect(page).to have_content('cs4470')
    end

    scenario 'creating an outline with invalid course code' do
    #  pending "add test once api is sorted #{__FILE__}"
    end

  end
end