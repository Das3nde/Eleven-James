window.timer_ref = 0
$ ->
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