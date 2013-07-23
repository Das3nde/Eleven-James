# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

approve_user =
  init: ->
    $('#approve_user').bind 'change', ->
      if confirm("Are you sure you want to change user's status")
        user_id = $(this).attr('data-user-id')
        approval_status = $(this).val()
        $.ajax '/admin/members/approval',
          type: 'POST'
          data:
            user_id: user_id
            approval: approval_status
          error: (jqXHR, textStatus, errorThrown) ->
          success: (data, textStatus, jqXHR) ->
            alert('Done!')

$ ->
  console.log('sd')
  approve_user.init()