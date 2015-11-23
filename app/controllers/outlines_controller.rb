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

    @current_outlines = Outline.recent_oultines(2);
    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  def show

  end

  def new

  end

  def create
    @outline.user = current_user
    @outline.save
    redirect_to edit_outline_path(id: @outline.id)
  end

  def edit

  end

  def search
    @query = params[:search][:query] if params[:search]
    @outlines = Outline.search_query(@query)
  end

  private

  def outline_params
    params.require(:outline).permit(:course_id)
  end
end
