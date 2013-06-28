window.center_button_row = ->
  $(".button-row:not('.not-centered'), .dynamic-centered").each ->
    width = 0
    $("> *", this).each ->
      $this = $(this)
      width += $this.outerWidth(true)
    $(this).width width

window.onload = ->
  center_button_row()

update_select = (sel_instance) ->
  val = $(sel_instance).val()
  text_value = $(sel_instance).find("option[value='" + val + "']").text()
  $(sel_instance).parents(".select-wrapper").find(".value").text text_value


$ ->
  # button conflict between bootstrap and jqueryui
  # noConflict() #was causing an error, so killing this line for now
  btn = $.fn.button.noConflict() # reverts $.fn.button to jqueryui btn
  btn = $.fn.button
  $.fn.btn = btn
  model_id = null
  # assigns bootstrap button functionality to $.fn.btn
  arrange_queue = ->
    $("ul.ej-queue li.wrap").removeClass "wrap"
    $("ul.ej-queue li:nth-child(2n)").addClass "wrap"

  path_parts = document.location.pathname.split('/')
  action = path_parts.pop() || 'index'
  page = path_parts.pop()
  url = if action == 'index' then '' else action
  $.get( url, {}, (html)->
    $el = $('.ej-tabs [data-action='+action+']')
    refresh_tab($el, action)
  )

  $(".ej-tabs").each ->
    active = 0
    active = $(this).data("active")  if $(this).data("active") isnt 'undefined'
    $(this).tabs({
      active: active,
      activate: (e, i)->
        $el = $(i.newPanel)
        action = $el.attr('data-action')
        refresh_tab($el, action)
    })

  refresh_tab = ($el, action) ->
    if($el.attr('id')!= 'add-product')
      $('#add-product').attr('data-action', 'add_product')
      $('a[href="#add-product"]').html('Add Model')
    if(action != undefined)
      url = if action == 'index' then '' else action
      $.get(url, {}, (html)->
        action = action || "all_products"
        if($.isNumeric(action) || action.substr(5,1) == '-')
          if(page == 'products')
            action = 'add_product'
          else
            action = 'view_item'
        refresh_method = refresh_tab_methods[page][action]
        (refresh_method && refresh_method.norefresh) || $el.html(html)
        $(".select-wrapper select").on "change", ->
          update_select(this)

        $(".select-wrapper select").each ->
          update_select(this)
        if(refresh_method && !refresh_method.norefresh)
          $el.ready(()->
            refresh_method.call(refresh_method, $el, html)
          )
      )

  $(".ej-modal").each ->
    $this = $(this)
    width = $this.data("width") or 537
    $(this).dialog
      modal: true
      width: width
      draggable: false
      resizable: false
      dialogClass: "ej-modal"
      autoOpen: $this.data("open")
      open: ->
        $this = $(this)
        $this.find(".button-close").click (e) ->
          $this.dialog "close"

        $(".ui-widget-overlay").click (e) ->
          $this.dialog "close"

        $this.parents(".ui-dialog").addClass($this.data("class")).css "top", "60px"
        center_button_row()
        if $(@).attr("id") == "image-zoom-popup"
          $('#image-zoom-popup .image-content').one "load", ->  
            width = $(@).parents(".ui-dialog").width()
            $(@).parents(".ui-dialog").css({
              marginLeft: "-#{width/2}px"
            }).find(".image-content").css({
              width:"100%"
            })
        
          
  $("body").delegate ".ej-notification .close", "click", ->
    $(this).parents(".ej-notification").fadeOut 700, ->
      $(this).remove()


  $("ul.ej-queue li .close").click ->
    request_id = $(this).attr('data-request-id')
    $.ajax '/delete_request',
      type: 'DELETE'
      dataType: 'json'
      data:
        request_id : request_id
      error: (jqXHR, textStatus, errorThrown) ->
      success: (data, textStatus, jqXHR) ->

    $(this).parent().fadeOut 700, ->
      $(this).remove()
      arrange_queue()



  $("#homepage-slider").bjqs
    width: 1084
    height: 531
    animduration: 1450
    animspeed: 6000
    showmarkers: false
    keyboardnav: false
    nexttext: "&nbsp;"
    prevtext: "&nbsp;"
    randomstart: false
    responsive: false
    automatic: true

  $(".photo-slider").bjqs
    width: 540
    height: 675
    automatic: false
    showcontrols: false
    keyboardnav: false
    randomstart: false
    responsive: false
    centermarkers: false

  $(".photo-slider .bjqs-markers.real a").click ->
    index = $(this).parents("ol").find("li").index()
    $(this).parents(".bjqs-markers").next().find("li").eq(index).trigger "click"
    false

  $(".static-slider").each ->
    $(this).bjqs
      width: 302
      height: 384
      automatic: false
      showmarkers: false
      keyboardnav: false
      nexttext: "&nbsp;"
      prevtext: "&nbsp;"
      randomstart: false
      responsive: false
      centercontrols: false

  $("#account-page #frequency.ui-tabs .buttonset").buttonset create: ->
    $this = $(this)

    $this.find("li").click ->
      $this.find("li .number").html('&nbsp;')
      count = 0
      $this.find("label.ui-state-active").each ->
        count += 1
        $(this).parents("li").first().find(".number").text count

  $(".buttonset").buttonset create: ->
    $this = $(this)
    $this.find("li").click ->
      $this.find("li").removeClass("active")
      $(this).addClass("active")


  $("#signup-page .dual-radio").buttonset create: ->
    $this = $(this)
    $this.find("label").click ->
      $this.find(">div").removeClass "selected"
      $(this).parent().addClass "selected"


  $("#signup-page .step2").buttonset create: ->
    $this = $(this)
    $this.find("label").click ->
      $this.find(".title").removeClass "selected"
      $(this).parent().addClass "selected"


  $("#signup-page .checkbox-row input").button()
  $(".shipping-billing-same input").prop "checked", false
  $(".shipping-billing-same input").on "change", ->
    $(".shipping-info").toggleClass "disable"





refresh_tab_methods = {
  products:{
    index: () ->
      $('.ej-table tbody tr').click(()->
        id = $(this).attr('data-id')
        $('#add-product').attr('data-action', id)
        $('a[href="#add-product"]').html('Edit Model')
        $('.ej-tabs').tabs('select', 1);
      )
    add_product : ()->
      handle_vendor_form = ()->
        $('.vendor-dialog').dialog()
        $('.simple_form.vendor').validate({
          submitHandler: (form)->
            $.ajax({
                   type: "POST",
                   data: $(form).serialize()
                   url: "/admin/vendors",
                   success: (response)->
                     $new_vendor = $('<option value="' + response.id + '">' + response.name + '</option>')
                     $new_vendor.insertBefore('#product_vendor_id option[value=""]')
                     $('.vendor-dialog').dialog('close')
                     $('#product_vendor_id').val(response.id)
                     update_select($('#product_vendor_id'))
                   error: ()->
                     alert("An unexpected error has occurred")
                   },
                   type: 'json'
            )
            return false
          })



      #Vendor editing stuff --------------------------------------------------
      $vendor_select = $('#product_vendor_id')
      $empty_option = '<option value="">Add Vendor</option>'
      $vendor_select.append($empty_option)
      $vendor_select.change(()->
        if(!$vendor_select.val())
          handle_vendor_form()
      )
      if($vendor_select.find('option').length == 1 )
        $('.select-wrapper.vendor').click(handle_vendor_form)
      $('.button.save').click(()->
        $product_form = $('.simple_form.edit_product')
        $.post($product_form.attr('action'), $product_form.serialize(), (result)->
          console.log
        , 'json')
        return false
      )

      #Image upload stuff --------------------------------------------------
      $('#photos').delegate('li','click',()->
        id = this.dataset.id
        $.ajax({
               url: '/admin/product_images/'+id
               type: "GET",
               dataType: 'script',
               })
      )
      $('#product_image_image').change(()->
        val = this.value
        ext = val.substring(val.lastIndexOf('.') + 1);
        if($.inArray(ext, ['png', 'jpg', 'jpeg', 'gif']) == -1)
          consle.log($.inArray(ext, ['png', 'jpg', 'jpeg', 'gif']))
          alert('Must be a valid image format')
          this.value = null
        else
          $('.new_product_image').submit()
      )
      $('#upload_iframe').load(()->
        try
          data = JSON.parse($(this).contents().text())
          if(data.thumb_src)
            $('#photos').append('<li data-id='+data.id+'><img src='+data.thumb_src+'/>/ +
                                                         /<div class="edit-bar"><a href="#">Edit</a>  +
                                                           <div class="arrows"><a class="left" href="#">&lt;</a><a class="right" href="#">&gt;</a>  +
                                                             </div></div></li>')
          else if(data.error)
            alert(data.error)

        catch e
      )

      $('#add-inventory').click(()->
        url = $('.simple_form.edit_product').attr('action') + '/add_inventory'
        auth = $('.simple_form.edit_product input[name=authenticity_token]').val()
        $.ajax({
               type: "POST",
               url: url,
               data: {authenticity_token:auth}
               success: (response)->
                 $('#model-inventory').append('<li class="cgrid"><div class="number alpha">'+response.id+'</div><a class="edit omega" href="#"></a></li>')
                 $('.count.omega').html(response.quantity)

               error: ()->
                 alert("An unexpected error has occurred")
               })

        return false
      )

    featured: () ->
      $(".bjqs-wrap").each ->
        width = $(@).data("width")
        height = $(@).data("height")
        $(@).bjqs
          width: width
          height: height
          animduration: 1450
          animspeed: 6000
          automatic: false
          showmarkers: false
          keyboardnav: false
          nexttext: ">"
          prevtext: "<"
          randomstart: false
          responsive: false
  },
  inventory : {
    index: ()->
      $('.ej-table tr').click(()->
        id = this.dataset.id
        add_inventory_tab(id)
      )
    view_item : ($el)->
      _this = this
      $dialog = $('#service_dialog')
      $panel = $('.ui-tabs-panel:last-child')
      refresh = -> _this.call(_this, $el)

      setTimeout(()-> #this is retarded, but I have no idea why it doesn't work otherwise
        $status_panel = $('#status_panel')
        $hover_status = $('#hover_status')
        $trs = $('#admin-manage-inventory .ej-table tbody tr')
        $el.find('a.remove-record').click(()->
          if(confirm('Are you sure you want to remove this event? Any associated transit records will also be deleted'))
            id = this.dataset.id
            $.post('remove_record', {
                   authenticity_token:AUTH_TOKEN,
                   id: id
              }, (res)->
                $panel.html(res)
                refresh()
            )
          return false
        )
        $el.find('form.edit_storage_record').change(()->
          $.post(this.action, $(this).serialize(), ()->
          )
          return false
        )
        $('label:has(#storage_record_is_available[disabled])').click(->
          return false
        )
        $('#add_service_button').click(->
          if($dialog.hasClass('ui-dialog'))
            $dialog.dialog('open')
          else
            $('#service_dialog').remove()
            $dialog = $dialog.dialog()
            $('#add_service_form').submit(->
              $.post('add_service/'+$panel[0].dataset.action, $(this).serialize() ,(res) ->
                $panel.html(res)
                $dialog.dialog('destroy')
                $dialog.remove()
                refresh()
              )
              return false
            )
        )
        $trs.hover(->
          $.get('status/'+this.dataset.id,{}, (res)->
            $hover_status.html(res)
          )
          $hover_status.show()
          $status_panel.hide()
        ->
          $hover_status.hide()
          $status_panel.show()
        ).click(->
          $trs.removeClass('highlight')
          $(this).addClass('highlight')
          $status_panel.html($hover_status.html())
          refresh_status_forms()
        )
        refresh_status_forms = ->
          $('.simple_form.transit').change(->
            data = $(this).serialize() + '&' + $.param({
              status_id : $('.right_col tr.highlight').data('id')
            })
            $.post(this.action, data, (res)->
              $el.html(res)
              refresh()
            )
          )
          $('.transit_form').change(->
            $.post(this.action, $(this).serialize()).fail(->
              alert('an unexpected error has ocurred')
            )
          )

        refresh_status_forms()
      , 30)
  }
  admins:{
    index: ->
      $('input[type=checkbox]').change(()->
        _this = this
        action = if this.checked then 'add' else 'remove'
        $.post(action+'_role',{
          authenticity_token:AUTH_TOKEN,
          id: get_row_id(this),
          role: this.name
        }).fail(->
          _this.checked = !_this.checked
          alert('An Unexpected Error Has Occurred')
        )
      )
      $('#new_user').submit(->
        $.post('', $(this).serialize(), (res)->
          html = '<tr data-id="'+res.id+'"><td>'+res.name+'</td><td>'+res.email+'</td><td><input name="courier" type="checkbox"></td><td><input name="editor" type="checkbox"></td><td><input name="superadmin" type="checkbox"></td></tr>'
          $('.ej-table').append(html)
          $('.error').html()
        ).fail((res)->
          errors = JSON.parse(res.responseText).errors
          _.each(errors, (v,k)->
            $('.error.'+k).html(v)
          )
        )
        return false
      )
  },
  shipping:{
    my_pickups: ($el) ->
      _this = this
      refresh = -> _this.call(_this, $el)
      $('.pickup, .cancel_pickup, .mark_delivered').click(->
        data = {
          id:get_row_id(this),
          authenticity_token:AUTH_TOKEN
        }
        action = $(this).attr('class')
        $.post(action, data, (res)->
          $el.html(res)
          refresh()
        )
      )
  }
  selection:{
    index: ->
      this.norefresh = true
      $(".select-wrapper select").on "change", ->
        update_select this

      $(".select-wrapper select").each ->
        update_select this

      $(".custom-select-wrapper").each ->
        $this = $(@)
        $ul = $("<ul />")
        $this.find("select option").each ->
          value = $(@).attr("value")
          text = $(@).text()
          text = value if $.trim(text) == ""
          $li = $("<li data-value='" + value + "'>" + text + "</li>")
          $ul.append($li)
        $this.find(".options").append($ul)

      $(".custom-select-wrapper").click ->
        $(@).find(".options").toggle()


      $( ".connected-sortable" ).sortable({
        connectWith: ".connected-sortable"
        update: (ev,ui)->
          $item = ui.item
          if($(this).hasClass('user-selection'))
            $item.addClass('locked')
            if($(this).find('li').length > 1)
              $old_item = $(this).find('li').eq(1)
              $old_item.removeClass('locked')
              $('#selection_products').append($old_item)

          else
            $item.removeClass('locked')
          check_paired()
        }).disableSelection()
      locked_pairs = ()->
        arr = _.map($('.locked'),(
          (item)->
            [item.dataset.id, $(item).parents('ul')[0].dataset.id] ))
        arr || []

      $('#selection_form').submit(()->
        data =  $(this).serialize() + '&' + $.param({
                                                    locked_pairs : locked_pairs(),
                                                    })
        $.post('get_pairs', data, (result)->
          _.each(result, (pair)->
            product_id = pair[0]
            user_id = pair[1]
            $('#user-'+user_id).append($('#product-'+product_id))
          )
          check_paired()

        , 'json')
        return false
      )
      check_paired = ()->
        action = if ($('.user-selection li').length != 0) then 'show' else 'hide'
        $('#distribute_button')[action]()
        action = if ($('.user-selection li').length == $('.user-selection').length) then 'hide' else 'show'
        $('#run_selection')[action]()

      $('#distribute_button').click(()->
        pairs = _.map($('.user-selection li'), (item)->
          [item.dataset.id,item.parentNode.dataset.id]
        )
        if confirm('Are you sure you want to distribute these '+ pairs.length + ' items?')
          params = {
          pairs:pairs,
          authenticity_token: $('input[name=authenticity_token]').val()
          }
          $.post('distribute', params, ()->
            $('.user-slot:has(li)').remove()
          ,'json')
        return false
      )
  }
}

get_row_id = ($el)->
  $($el).parents('tr').data('id')

add_inventory_tab = (id)->
  console.log('is this called more than once?')
  if($('.ui-tabs-anchor').length < 4)
    $('.ej-tabs').tabs("add", id, id)
  else
    $('.ui-tabs-nav:last-child span').html(id)
  $('.ui-tabs-panel:last-child').attr('data-action', id)
  $('.ej-tabs').tabs('select', 3)
