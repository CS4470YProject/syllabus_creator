$ ->
  $('#edit_outlines').html("<%= escape_javascript(render 'outlines/partials/edit_element', outline: @outline) %>")
  $('.ckeditor').ckeditor()