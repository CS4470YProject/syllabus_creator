# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Editor
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

  this.updateOrder  = (editor_div) ->
    order_label = editor_div.children('.element-order')
    prev_value = order_label.attr('value')



$ ->

#Sortable functionality. Objects that hold sortable elements should have this css class
  $(".sortable").sortable
    revert: true
    stop: (e, ui) ->
      $.map $(this).find(".draggable"), (el) ->
        #set the ordering of each element whenever a drag finishes
        $(el).children("#element-order").val $(el).index()

  #Draggable functionality. Draggable elements should have this css class
  $(".draggable").draggable
    connectToSortable: ".sortable",
    revert: "invalid",
    iframeFix: true,
    start: (event, ui) ->
      Editor.disableEditor($(event.target))
    stop: (event, ui) ->

  ### Define 'create' elements here (elements that when dragged will create new content) ###
  ### The content of the clone is passed in from a hidden html input under the id element-html-content ###
  $(".cloneable").draggable
    connectToSortable: ".sortable"
    helper: (el) ->
      $  $(el.currentTarget).children('#element-html-content').val()
    revert: "invalid"

  $('#edit_outlines').on 'click', '.display-editor', (event,  ui) ->
    par = $(this).parents('.element-text')
    Editor.disableAllEditors()
    Editor.reloadEditor(par)

  $('#edit_outlines').on 'click', '.hide-editor', (event, ui) ->
    par = $(this).parents('.element-text')
    Editor.disableEditor(par)
    Editor.submitForm()