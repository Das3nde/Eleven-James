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
      user_id = $(this).attr('data-userid')
      switch $(this).attr('data-type')
        when 'que'
          self.que_list(user_id)
        when 'rotation'
          self.rotation_list(user_id)
        when 'suggestion'
          $('#que_list').html("To be implemented")
      false

  que_list: (user_id) ->
    $.ajax '/admin/page_member_que',
      type: 'GET'
      data:
        user_id: user_id
      success: (data, textStatus, jqXHR) ->

  rotation_list: (user_id) ->
    $.ajax '/admin/page_member_rotation_history',
      type: 'GET'
      data:
        user_id: user_id
      success: (data, textStatus, jqXHR) ->

prospects =
  init: ->
    if $('#prospect_section').length > 0
      $.ajax '/admin/prospects',
        type: 'GET'
        success: (data, textStatus, jqXHR) ->

generate_invite =
  init: ->
    this.search()
    this.click_event()

  click_event: ->
    $('#prospect_search_list').on "click", "div > a", ->
      $('#invite_name').val($(this).attr('data-name'))
      $('#invite_email').val($(this).attr('data-email'))
      false

  search: ->
    if $('#invite_section').length > 0
      $('#search_prospect').on 'keyup', ->
        val = $(this).val()
        $.ajax '/admin/search_prospect',
          type: 'POST'
          data:
            term: val
          success: (data, textStatus, jqXHR) ->


$ ->
  approve_user.init()
  que_history.init()
  prospects.init()
  generate_invite.init()