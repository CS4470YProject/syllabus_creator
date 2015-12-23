class CoursesController < ApplicationController
  autocomplete :course, :code, full: true
end
