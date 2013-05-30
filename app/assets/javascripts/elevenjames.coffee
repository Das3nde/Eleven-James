
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

$ ->
  # button conflict between bootstrap and jqueryui
  # noConflict() was causing an error, so killing this line for now
  #btn = $.fn.button.noConflict() # reverts $.fn.button to jqueryui btn
  btn = $.fn.button
  $.fn.btn = btn # assigns bootstrap button functionality to $.fn.btn
  arrange_queue = ->
    $("ul.ej-queue li.wrap").removeClass "wrap"
    $("ul.ej-queue li:nth-child(2n)").addClass "wrap"
  update_select = (sel_instance) ->
    val = $(sel_instance).val()
    text_value = $(sel_instance).find("option[value=" + val + "]").text()
    $(sel_instance).parents(".select-wrapper").find(".value").text text_value

  $(".ej-tabs").each ->
    active = 0
    active = $(this).data("active")  if $(this).data("active") isnt `undefined`
    $(this).tabs({
                 active: active
                 activate: (e, i)->
                   $el = $(i.newPanel)
                   action = $el.attr('data-action')
                   console.log(action)
                   $.get('/admin/products/'+action, {}, (html)->
                     console.log("CHOOOOSE")
                     $el.html(html)
                     if($("#product_vendor_id option").length == 0)
                       $("#product_vendor_id").attr('data-placeholder', 'Enter a vendor name')
                       $("#product_vendor_id").append('<option value=""></option>')

                     $("#product_vendor_id").chosen({
                                                    no_results_text: "Add Vendor"
                                                    no_results_callback: ($results, terms)->
                                                      console.log("balls")
                                                      $results.click(()->
                                                        console.log("balls")
                                                      )
                                                    })
                     $('.chzn-search input').keydown((e)->
                       chosen = $("#product_vendor_id").data('chosen')
                       has_results = $('.chzn-results .active-result').length != 0
                       if(e.which == 13 && !has_results)
                         console.log("ENTER!!!")
                         $('.modal').dialog()
                         $('#vendor_name').val($('.chzn-search input').val())
                         return false
                       return true;
                     )

                     $('.chzn-results').delegate('.no-results','click',()->
                       $('.modal').dialog();
                     )

                     if($('.simple_form.vendor').validate)
                         $('.simple_form.vendor').validate({
                           submitHandler: (form)->
                             $.ajax({
                                    type: "POST",
                                    data: $(form).serialize()
                                    url: "/admin/vendors",
                                    success: (response)->
                                      console.log(response)
                                      $("#product_vendor_id").append('<option value="'+response.id+'">'+response.name+'</option>')
                                        .trigger("liszt:updated")
                                      $('.modal').dialog('close')
                                    error: ()->
                                      alert("An unexpected error has occurred")
                                    },
                                    type:'json'
                             )
                             return false
                           })
                   )

    })

  ###
  get_product = (id, compiled)->
    $.get('/admin/products/new', {}, (res)->
      $('#add-model').html(compiled(res))
      console.log(compiled(res))
      $('#product_image_image').change(()->
        val = this.value
        ext = val.substring(val.lastIndexOf('.') + 1);
        console.log(ext)
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
            $('#photos').append('<li data-id='+data.id+'><img src='+data.thumb_src+'/></li>')
          else if(data.error)
            alert(data.error)

        catch e
      )
    , 'json')
  ###



  $(".ej-modal").each ->
    $this = $(this)
    width = $this.data("width") or 537
    # console.log(autoopen)
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
        count+=1
        $(this).parents("li").first().find(".number").text count
        console.log( $(this).parents("li").first().find(".number"))

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
      $li = $("<li data-value='"+value+"'>"+text+"</li>")
      $ul.append($li)
    $this.find(".options").append($ul)

  $(".custom-select-wrapper").click ->
    $(@).find(".options").toggle()
    
    