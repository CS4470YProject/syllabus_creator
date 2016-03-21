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
    @template = @outline.parent
    @course_code = params[:course][:course_code]
  end

  def clone
    @current_job = CloneTemplate.perform_later(user_id: current_user.id,
                                               course_code: params[:course_code],
                                               parent_id: params[:outline_id],
                                               senate_rules: senate_rules)
  end

  def edit

  end

  def search
    @query = params[:search][:query] if params[:search]
    @outlines = Outline.search_query(@query)
  end

  def update
    @outline.update_attributes(outline_params)
    respond_to do |format|
      format.html { redirect_to edit_outline_path }
      format.js {}
    end
  end

  def add_element
    #TODO: Add order to the element
    @outline = Outline.where(id: params[:outline_id]).first
    @element = @outline.add_element(5) #Change this
  end

  def remove_element
    outline_element = OutlineElement.where(id: params[:outline_element_id].to_i).first
    outline_element.destroy
    @outline_element_id = params[:outline_element_id]
  end

  private

  def outline_params
    params.require(:outline).permit(:course_id, :parent_id, header_attributes:[:text, :bold, :italic, :underline, :size], element_groups_attributes:[:id, :rank, elements_attributes:[:id, :text, :rank, header_attributes:[:text, :bold, :italic, :underline, :size]]])
  end
  def senate_rules
    params.require(:senate_rules)
  end
end
