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
    $('.edit_outline').submit()

  this.updateOrder  = ->
    pos = 0
    $.map $(".element-edit"), (event) ->
      $(event).children(".element-order").val pos++

  this.enableSortable = ->
    $('.element-group-list').sortable
      revert: true,
      start: (event, ui) ->
        Editor.disableEditor($(ui.item).children('.element-text'))
      stop: (event, ui) ->
        Editor.updateOrder(0)
      connectWith: '.element-group-list',
      beforeStop: (ev, ui) ->
        if( $(ui.item).hasClass('element-group') && $(ui.placeholder).parent()[0] != this )
          $(this).sortable('cancel')
    $('.elements').sortable
      connectWith: '.elements',
      stop: (event, ui) ->
        console.log 'asdasd'

  this.enableToolbarDraggable = ->
    ### Define 'create' elements here (elements that when dragged will create new content) ###
    ### The content of the clone is passed in from a hidden html input under the id element-html-content ###
    $(".cloneable").draggable
      connectToSortable: ".sortable"
      helper: (el) ->
        $  $(el.currentTarget).children('.element-html-content').val()
      revert: "invalid"
      start: (event, ui) ->
        Editor.disableEditor($(ui.item).children('.element-text'))
      stop: (event, ui) ->
        Editor.updateOrder(0)