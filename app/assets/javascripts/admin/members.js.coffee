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

que_history =
  init: ->
    this.tab_event()
    $( "#que_history > .header > a:first").trigger('click')
  tab_event: ->
    self = @
    $( "#que_history > .header > a").bind 'click', ->
      $(this).siblings().removeClass('active')
      $(this).addClass('active')
      switch $(this).attr('data-type')
        when 'que'
          self.que_list()
        when 'rotation'
          self.rotation_list()
        when 'suggestion'
          $('#que_list').html("To be implemented")
      false

  que_list: ->
    $.ajax '/admin/page_member_que',
      type: 'GET'
      success: (data, textStatus, jqXHR) ->
  rotation_list: ->
    $.ajax '/admin/page_member_rotation_history',
      type: 'GET'
      success: (data, textStatus, jqXHR) ->

$ ->
  approve_user.init()
  que_history.init()