$ ->
  $('#alert-div').html("<div class='alert alert-info'> Processing <span class='fa fa-spinner fa-spin'></span> </div> ")
  $.poll (retry) ->
    $.getJSON "<%= job_message_path(@current_job.job_id) %>", (data) ->
      if data
        console.log data.status
        if data.status == "succeeded"
          console.log 'Winner'
          $('#alert-div').html("<div class='alert alert-success'> Finished </div> ")
        else
          retry()
      else
        retry()





