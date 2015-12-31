class JobMessagesController < ApplicationController

  def show
    @job_message = Rails.cache.fetch(params[:job_id])
    respond_to do |format|
      format.json { render 'show' }
    end
  end

end