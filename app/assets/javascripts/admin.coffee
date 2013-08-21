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

  $("#manage-members #generate-invite.ui-tabs .right-column.omega .results").tinyscrollbar()

  $("body.elevenjames #manage-members #members.ui-tabs .action-bar .action-bar-dropdown-area > .arrow").on "click", ->
    $(@).next().toggle()

  $(".admin-wrapper .export.button").click ->
    $("#export-inventory-modal").dialog "open"

  $(".admin-wrapper .add_a_record.button").click ->
    $("#add-record-modal").dialog "open"

  $("table.ej-table td.arrow img").live 'click', ->
    $(@).parents("tr").toggleClass("highlight");


  prepare_multiselect()

  $(".token-input-wrap .arrow").click ->
    $(@).parents('.token-input-wrap').find(".dropdown").slideToggle()

apply_tiny_mce = ->
  tinyMCE.init
    mode: "specific_textareas"
    editor_selector: "tinymce"
    theme: "advanced"
    theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect"

    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor"

    theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen"

    theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage"

    theme_advanced_toolbar_location: "top"
    theme_advanced_toolbar_align: "left"
    theme_advanced_statusbar_location: "bottom"
    theme_advanced_buttons3_add: "tablecontrols,fullscreen"
    plugins: "table,fullscreen"
    language: "en"

$ ->
  apply_tiny_mce()
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

