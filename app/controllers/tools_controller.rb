class ToolsController < ApplicationController
  def search
    @query = params[:search][:query] if params[:search]
    @tools = Tool.search_query(@query)
  end

  #TODO: implement methods for adding, removing, and updating tools

  def add
    #can the user create a new element when making a tool, or only use existing
    #elements?
  end

  def remove
  end

  def update
  end
end
