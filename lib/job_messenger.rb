class JobMessenger


  def initialize(job_id, status, message=nil)
    @job_id = job_id
    @message = message
    @status = status
  end


end