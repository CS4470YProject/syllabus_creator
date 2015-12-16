class CloneTemplate < ActiveJob::Base
  queue_as :default

  attr_accessor :job_messenger
  before_enqueue do |job|
    @job_messenger = JobMessenger(job_id, :queued)
  end

  def perform(params)
    debugger
    begin
      @job_messenger = JobMessenger(job_id, :running)
      user = User.find(params[:user_id])
      template = Template.find(params[:template_id])
      #template.clone(user, params[:course_code])
    rescue => e
      Rails.logger.error e.message

    end

  end

end


