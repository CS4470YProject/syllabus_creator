# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
 #Sortable functionality. Objects that hold sortable elements should have this css class
 $(".sortable").sortable
   revert: true
   stop: (e, ui) ->
     $.map $(this).find(".draggable"), (el) ->
       $(el).attr "index", $(el).index()

 #Draggable functionality. Draggable elements should have this css class
 $(".draggable").draggable
   connectToSortable: ".sortable"
   evert: "invalid"

 ### Define 'create' elements here (elements that when dragged will create new content) ###
 $("#create-paragraph").draggable
   connectToSortable: ".sortable"
   helper: ->
     $  "<div class='draggable'>" +
         "<h3>Heading</h3>" +
         "<p>New content element</p>" +
         "</div>"
   revert: "invalid"
