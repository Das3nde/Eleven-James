# 		console.log(active);

# 		console.log([$this.parents(".ui-dialog").get(0), width]);

# 		console.log([index,$(this).parents(".bjqs-markers").next().find("li").eq(index).find("a")])

# 		console.log($(".shipping-info"));

#         console.log(text_value)
window.center_button_row = ->
  $(".button-row:not('.not-centered'), .dynamic-centered").each ->
    width = 0
    $("> *", this).each ->
      $this = $(this)
      # console.log $this.outerWidth(true)
      width += $this.outerWidth(true)
    # 			console.log($this.outerWidth(true));
    # console.log width
    $(this).width width

window.onload = ->
  center_button_row()
# console.log("zsd")

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
  action = path_parts.pop() || $('.ui-tabs')[0].dataset.action
  page = path_parts.pop()

  console.log("action", action)
  console.log("page", page)
  $.get(action, {}, (html)->
    refesh_method = refresh_tab_methods[page][action]
    $el = $('.ej-tabs [data-action='+action+']')
    $el.html(html)
    console.log($el)
    refesh_method($el, html)
  )

  $(".ej-tabs").each ->
    active = 0
    active = $(this).data("active")  if $(this).data("active") isnt 'undefined'
    $(this).tabs({
      active: active,
      activate: (e, i)->
       $el = $(i.newPanel)
       action = $el.attr('data-action')
       if($el.attr('id')!= 'add-product')
         $('#add-product').attr('data-action', 'add_product')
         $('a[href="#add-product"]').html('Add Model')
       if(action != undefined)
         $.get(action, {}, (html)->
           action = action || "all_products"
           if($.isNumeric(action) && page == 'products')
             action = 'add_product'
           else
             action = 'view_item'
           refresh_method = refresh_tab_methods[page][action]
           $el.html(html)
           $(".select-wrapper select").on "change", ->
               update_select(this)

           $(".select-wrapper select").each ->
             update_select(this)
           if(refresh_method)
            refresh_method($el, html)
         )
      })

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


  $("body").delegate ".ej-notification .close", "click", ->
    $(this).parents(".ej-notification").fadeOut 700, ->
      $(this).remove()


  $("ul.ej-queue li .close").click ->
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



refresh_tab_methods = {
  products:{
    products: () ->
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
          console.log("ooo")

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
        console.log("image changed")
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
    inventory: ()->
      $('.ej-table tr').click(()->
        id = this.dataset.id
        $('.ej-tabs').tabs("add", id, 'View Item');
        $('.ui-tabs-panel:last-child').attr('data-action', id)
        $('.ej-tabs').tabs('select', 4);
        console.log("should be working")
      )
  }
}