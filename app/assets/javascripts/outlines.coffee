# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#edit_outlines').on 'click', '.display-editor', (event,  ui) ->
    par = $(this).parents('.element-text')
    Editor.disableAllEditors()
    Editor.reloadEditor(par)

  $('#edit_outlines').on 'click', '.hide-editor', (event, ui) ->
    par = $(this).parents('.element-text')
    Editor.disableEditor(par)
    Editor.submitForm()

  $('.toggle-check').bootstrapSwitch('state', true)
#
#  $('div.element-group-list').sortable({
#    connectWith: 'div.element-group-list',
#    beforeStop: (ev, ui) ->
#      if( $(ui.item).hasClass('element-group') && $(ui.placeholder).parent()[0] != this )
#        $(this).sortable('cancel')
#  })

  $('div.elements').sortable({
    connectWith: 'div.element'
  })


  Editor.enableSortable()
  Editor.enableToolbarDraggable()

