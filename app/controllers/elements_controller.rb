class ElementsController < ApplicationController
  load_and_authorize_resource
  def destroy
    @element.destroy
    respond_to do |format|
      format.js {}
    end
  end
end
