# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#  #Draggable functionality. Draggable elements should have this css class
#  $(".draggable").draggable
#    connectToSortable: ".sortable",
#    revert: "invalid",
#    revertDuration: 0,
#    start: (event, ui) ->
#      Editor.disableEditor($(event.target).children('.element-text'))
#    stop: (event, ui) ->
#      setTimeout(Editor.updateOrder, 1100)

  $('#edit_outlines').on 'click', '.display-editor', (event,  ui) ->
    par = $(this).parents('.element-text')
    Editor.disableAllEditors()
    Editor.reloadEditor(par)

  $('#edit_outlines').on 'click', '.hide-editor', (event, ui) ->
    par = $(this).parents('.element-text')
    Editor.disableEditor(par)
    Editor.submitForm()


  Editor.enableSortable()
  Editor.enableToolbarDraggable()

