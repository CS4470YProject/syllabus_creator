class OutlinesController < ApplicationController
  load_and_authorize_resource

  def index

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

  private

  def outline_params
    params.require(:outline).permit(:course_id)
  end
end
