# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # enable chosen js
  console.log($('.input-row #article_tags_list'))
  $('.form-group #article_tag_list').select2({tags: true})
