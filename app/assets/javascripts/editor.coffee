class @Editor

  this.disableEditor = (editor_div) ->
    editor_div.css('minHeight', '100px')
    editor_div.children('.html-element').removeClass('hidden')
    editor_div.find('.ckeditor-element').addClass('hidden')
    editor_id = editor_div.find('.ckeditor-element').find('textarea').attr('id')
    if editor_id && CKEDITOR['instances'][editor_id]
      html_data = CKEDITOR['instances'][editor_id].getData()
      editor_div.children('.html-element').children('.html-element-text').html(html_data)
      CKEDITOR['instances'][editor_id].destroy()

  this.reloadEditor = (editor_div) ->
    editor_div.css('minHeight', '350px')
    editor_div.find('.html-element').addClass('hidden')
    editor_div.find('.ckeditor-element').removeClass('hidden')
    editor_id = editor_div.find('.ckeditor-element').find('textarea').attr('id')
    if  CKEDITOR['instances'][editor_id]
    else
      CKEDITOR.replace(editor_id)

  this.disableAllEditors = ->
    $('.element-text').each ->
      Editor.disableEditor($(this))

  this.reloadAllEditors = ->

  this.submitForm = ->
    console.log $('#edit_outline_elements').find('form')
    $('#edit_outline_elements').find('form').submit()

  this.updateOrder = (parent) ->
    pos = 0
    $.map $(parent).children(".list"), (event) ->
      $(event).children(".list-rank").val pos++

  this.enableSortable = ->
    $('.element-group-list').sortable
      revert: true,
      start: (event, ui) ->
        console.log $(ui.item)
        Editor.disableEditor($(ui.item).children('.elements').children('.element-text'))
      stop: (event, ui) ->
        Editor.updateOrder(ui.item.parent())
        Editor.submitForm()
      connectWith: '.element-group-list',
      beforeStop: (ev, ui) ->
        if( $(ui.item).hasClass('element-group') && $(ui.placeholder).parent()[0] != this )
          $(this).sortable('cancel')
    $('.elements').sortable
      connectWith: '.elements',
      start: (event, ui) ->
        Editor.disableEditor($(ui.item))
      stop: (event, ui) ->
        Editor.updateOrder(ui.item.parent())
        Editor.submitForm()

  this.addToolElement = ->
    item = $('#new_element')
    Editor.updateOrder(item.parent())
    # determine if element is in a group. If so, set the group rank
    if $(item.parent()).parent().find('.list-rank')
      $('#add_tool_element').find('form').children('.group-rank').val $(item.parent()).parent().find('.list-rank').val()
    console.log $(item).children('.list-rank').val()
    $('#add_tool_element').find('form').children('.list-rank').val $(item).children('.list-rank').val()
    $('#add_tool_element').find('form').children('.element-id').val $(item).children('.element-id').val()
    Editor.submitForm()
    $('#add_tool_element').find('form').submit()

  this.enableToolbarDraggable = ->
    ### Define 'create' elements here (elements that when dragged will create new content) ###
    ### The content of the clone is passed in from a hidden html input under the id element-html-content ###
    $(".cloneable").draggable
      connectToSortable: ".elements"
      helper: (el) ->
        $  $(el.currentTarget).children('.element-html-content').val()
      revert: "invalid"
      start: (event, ui) ->
        Editor.disableEditor($(ui.item).children('.element-text'))
      stop: (event, ui) ->
        Editor.addToolElement()
