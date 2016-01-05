# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#Sortable functionality. Objects that hold sortable elements should have this css class
  $(".sortable").sortable
    revert: true
    stop: (e, ui) ->
      $.map $(this).find(".draggable"), (el) ->
        #$("#outline-form").prepend el #sets the element inside the form object
        $(el).children("#element-order").val $(el).index()

  #Draggable functionality. Draggable elements should have this css class
  $(".draggable").draggable
    connectToSortable: ".sortable"
    revert: "invalid"

  ### Define 'create' elements here (elements that when dragged will create new content) ###
  ### The content of the clone is passed in from a hidden html input under the id element-html-content ###
  $(".cloneable").draggable
    connectToSortable: ".sortable"
    helper: (el) ->
      $  $(el.currentTarget).children('#element-html-content').val()
    revert: "invalid"
