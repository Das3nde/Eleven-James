
# 		console.log(active); 

# 		console.log([$this.parents(".ui-dialog").get(0), width]); 

# 		console.log([index,$(this).parents(".bjqs-markers").next().find("li").eq(index).find("a")]) 

# 		console.log($(".shipping-info")); 

#         console.log(text_value) 
center_button_row = ->
  $(".button-row:not('.not-centered'), .dynamic-centered").each ->
    width = 0
    $("> *", this).each ->
      $this = $(this)
      width += $this.outerWidth(true)

    
    # 			console.log($this.outerWidth(true)); 
    # console.log width
    $(this).width width

$ ->
  arrange_queue = ->
    $("ul.ej-queue li.wrap").removeClass "wrap"
    $("ul.ej-queue li:nth-child(2n)").addClass "wrap"
  update_select = (sel_instance) ->
    val = $(sel_instance).val()
    text_value = $(sel_instance).find("option[value=" + val + "]").text()
    $(sel_instance).parents(".select-wrapper").find(".value").text text_value
  center_button_row()
  $(".ej-tabs").each ->
    active = 0
    active = $(this).data("active")  if $(this).data("active") isnt `undefined`
    $(this).tabs active: active

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

