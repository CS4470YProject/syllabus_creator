class LandingController < ApplicationController
  autocomplete :course, :code
  def index
    @user = current_user
    @courses = Course.all
    @templates = Template.all
  end
end