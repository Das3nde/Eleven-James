window.timer_ref = 0
window.prepare_multiselect = ->
  $("select.custom_select_wrapper").each ->
    width = $(@).data("width") || null
    css_class = $(@).data("class") || null
    noneSelectedText = $(@).data("prompt") || "Select"
    $this = $(@)
    $this.multiselect {
      header: false,
      height: "auto",
      noneSelectedText: noneSelectedText,
      classes: "#{css_class} checkbox-tiny",
      create: ->
        # console.log($(".ui-multiselect-menu.#{css_class}"))
        $(".ui-multiselect-menu.#{css_class} label").each ->
          $input = $(@).find("input").remove()
          $(@).after($input)
        $(".ui-multiselect-menu.#{css_class}").buttonset()
    }
    unless width == null
      $(@).next().css('width', width+'px')
$ ->
  # remove model modal
  $(".admin-wrapper #admin-manage-models #add-model .right_col .remove-model").click ->
    $("#remove-model-modal").dialog "open"
  $("table.ej-table td.arrow img").click ->
      $(@).parents("tr").toggleClass("highlight");

  
  prepare_multiselect()
  
  $(".token-input-wrap .arrow").click ->
    $(@).parents('.token-input-wrap').find(".dropdown").slideToggle()
      
    
  $("#site-footer .admin-footer .sitemap li").hover(
    ->
      clearTimeout window.timer_ref
      $this = $(@)
      $("#site-footer .admin-footer .sitemap li").removeClass("hover")
      $this.addClass "hover"
      data_menu = $this.find("a").data "menu"
      $("#site-footer .admin-footer .submenu##{data_menu}").show()
    ->
      window.timer_ref = setTimeout( 
        ->
          $("#site-footer .admin-footer .submenu").hide();
          $("#site-footer .admin-footer .sitemap li").removeClass("hover")
        , 100
      )
  )
  
  $("#site-footer .admin-footer .submenu").hover(
    ->
      clearTimeout window.timer_ref
    ->
      $("#site-footer .admin-footer .submenu").hide()
      $("#site-footer .admin-footer .sitemap li").removeClass("hover")
  )