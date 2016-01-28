class CloneTemplate < ActiveJob::Base
  queue_as :default

  before_enqueue do |job|
    job_messenger = JobMessenger.create(job_id: job_id, status: :queued)
    PopulateCache.populate_for_job(job_messenger, job_id)
  end

  def perform(params)
    begin
      job_messenger = JobMessenger.where(job_id: job_id).first
      job_messenger.update_attributes(status: :running)
      PopulateCache.populate_for_job(job_messenger, job_id)
      user = User.find(params[:user_id])
      template = Template.find(params[:parent_id])
      @outline = template.clone(user, params[:course_code], params[:senate_rules])
    rescue => e
      Rails.logger.error e.message
      job_messenger.update_attributes(status: :failed, message: e.message)
      PopulateCache.populate_for_job(job_messenger, job_id)
      raise e
    end
    path = Rails.application.routes.url_helpers.edit_outline_path(@outline)
    job_messenger.update_attributes(status: :succeeded, message: path)
    PopulateCache.populate_for_job(job_messenger, job_id)
  end

end


