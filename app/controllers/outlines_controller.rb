class OutlinesController < ApplicationController
  load_and_authorize_resource

  def index
    @filterrific = initialize_filterrific(
        Outline,
        params[:filterrific],
        select_options: {
            sorted_by: Outline.options_for_sorted_by
        }
    ) or return
    @outlines = @filterrific.find.page(params[:page])

    @current_outlines = Outline.recent_outlines(2);
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  def show

  end

  def new
    parent_id = @outline.parent_id
    @current_job = CloneTemplate.perform_later(user_id: current_user.id, course_code: params[:course][:course_code], parent_id: parent_id)
  end

  def create
    @outline.user = current_user
    @outline.save
    @current_job = CloneTemplate.perform_later(course_code: 'cs4444') #populate this correctly
    redirect_to edit_outline_path(id: @outline.id)
  end

  def edit

  end

  def clone
    user_id = current_user.id
    course_code = 'cs4444' # TODO: Get this from user
    template_id = Template.first.id # TODO: Get this from user
    @current_job = CloneTemplate.perform_later(user_id: user_id, template_id: template_id, course_code: course_code)
  end

  def search
    @query = params[:search][:query] if params[:search]
    @outlines = Outline.search_query(@query)
  end

  private

  def outline_params
    params.require(:outline).permit(:course_id, :parent_id)
  end
end
