$ ->
  $('#alert-div').html("<div class='alert alert-info'> Processing <span class='fa fa-spinner fa-spin'></span> </div> ")
  $.poll (retry) ->
    $.getJSON "<%= job_message_path(@current_job.job_id) %>", (data) ->
      if data
        if data.status == "succeeded"
          $('#alert-div').html("<div class='alert alert-success'> Finished Processing. Reloading...  </div> ")
          setTimeout (->
            location.reload()
            return
          ), 1500
        else if data.status == "failed"
          $('#alert-div').html("<div class='alert alert-danger'> Processing failed: " + data.message + "</div>")
        else
          retry()
      else
        retry()

