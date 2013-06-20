# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

add_comment =
  init: ->
    this.show_form_event()
    this.rate_links()

  rate_links: ->
    $('#comment_form').find('.rating > section').find('a').bind 'click', ->
      cnt = $(this).attr('data-cnt')
      $section = $(this).closest('section')
      $section.find('input').val(cnt)
      arr = $section.find('a')
      arr.removeClass('fill')
      for i in [0...cnt]
        $(arr[i]).addClass('fill')

      false

  show_form_event: ->
    $('#comment_list').find('.comment-button').bind 'click', ->
      $('#comment_list').hide()
      $('#comment_form').show()

    $('#comment_form').find('.comment-button').bind 'click', ->
      $('#comment_list').show()
      $('#comment_form').hide()

helpful_comment =
  init: ->
    $('.comment-helpful').bind 'click', ->
      comment_id = $(this).attr('data-comment-id')
      flag = $(this).attr('data-flag')
      $.ajax
        url: "/comment_helpful"
        type: 'POST'
        data:
          comment_id: comment_id
          flag: flag
        success: (data) ->
          alert(data.message)

$ ->
  add_comment.init()
  helpful_comment.init()