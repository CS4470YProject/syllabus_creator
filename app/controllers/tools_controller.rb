class ToolsController < ApplicationController
  def search
    @query = params[:list][:query] if params[:list]
    @tools = Tool.list_query(@query)
  end

  #TODO: implement methods for adding, removing, and updating tools

  def new
    #can the user create a new element when making a tool, or only use existing
    #elements?
  end

  def remove
  end

  def update
  end
end
