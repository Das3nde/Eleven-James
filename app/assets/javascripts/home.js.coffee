
is_page = (page)->
  window.location.pathname.indexOf(page) != -1


$(()->
  $('#preference_page_size').change(()->
    $.get('', {page_size:$(this).val(), prefs:1},null, 'script')
  )
  _.each(['brand', 'model', 'tier'], (val)->
    $a = $('#'+val+'_sort');
    $a.click(()->
      $.ajax({
        type: "GET",
        dataType: 'script',
        data: {
          sort: val,
          prefs: 1,
          order: 1 #$a.attr('data-order')
        }
      })
      return false;
    )
  )
)

#add/edit products page
$(()->
  $('#upload_iframe').load(()->
    try
      data = JSON.parse($(this).contents().text())
      if(data.thumb_src)
        $('#photos').append('<li data-id='+data.id+'><img src='+data.thumb_src+'/></li>')
      else if(data.error)
        alert(data.error)

    catch e
  )

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
    console.log(ext)
    if($.inArray(ext, ['png', 'jpg', 'jpeg', 'gif']) == -1)
      consle.log($.inArray(ext, ['png', 'jpg', 'jpeg', 'gif']))
      alert('Must be a valid image format')
      this.value = null
    else
      $('.new_product_image').submit()
  )

  if($('#add_vendor').validate)
    $('#add_vendor').validate({
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
    #$('#add_vendor').submit(()->return false)

  if $().chosen
    if($("#product_vendor_id option").length == 0)
      $("#product_vendor_id").attr('data-placeholder', 'Enter a vendor name')
      $("#product_vendor_id").append('<option value=""></option>')

    $("#product_vendor_id").chosen({
      no_results_text: "Add Vendor"
      no_results_callback: ($results, terms)->
        $results.click(()->
          console.log("balls")
        )
    })
    $('.chzn-search input').keydown((e)->
      chosen = $("#product_vendor_id").data('chosen')
      has_results = $('.chzn-results .active-result').length != 0
      if(e.which == 13 && !has_results)
        $('.modal').modal()
        $('#vendor_name').val($('.chzn-search input').val())
        return false
      return true;
    )

    $('.chzn-results').delegate('.no-results','click',()->
      $('.modal').modal();
    )

  $('.modal .cancel').click(()->
    $('.modal').modal('hide');
    return false
  )

  $('#add-watch').click(()->
    $.ajax({
           type: "POST",
           url: "add_watch",
           success: (response)->
             $('#product_instances').append('<tr><td>'+response.id+'</td></tr>')
           error: ()->
             alert("An unexpected error has occurred")
           })

    return false
  )
)

if is_page('inventory')
  $(()->
    $('form').submit(()->
      $.post(this.action, $(this).serialize(), (record)->
        $('#history').append('<p id="record-'+record.id+'">'+record.product_id+
                             '<a href="/admin/records/'+record.id+'" data-action="destroy" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Destroy</a></p>')
      , 'json')

      return false
    )
    $('#history').on('click','[data-action="destroy"]',()->
        id = this.href.split('/').pop()
        jQuery.ajax({
          type: 'DELETE',
          url: this.href,
          success: ()->
            console.log("gret success!")
            $('#record-'+id).remove()
        })
        console.log("BALLLLLLSSSSSSS!!!!!!!!!")
        return false
    )
  )

#inventory records page


collection_list=
  init: ->
    if $('#info').length > 0
      this.show_page_add_to_collection()

    if $('#listing-layout').length > 0
      this.add_to_collection()
      this.filter_collection()
      this.reset_collection()

  show_page_add_to_collection: ->
    $('#info').find('a.add').bind 'click', ->
      $(this).html('Upgrade')
      product_id = $(this).attr('data-product-id')
      $.ajax '/request_product',
        type: 'POST'
        dataType: 'json'
        data:
          product_id: product_id
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

      false

  add_to_collection: ->
    $('#listing-layout').find('a.add').bind 'click', ->
      $(this).removeClass('add').addClass('upgrade').html('Upgrade')
      product_id = $(this).attr('data-product-id')
      $.ajax '/request_product',
        type: 'POST'
        dataType: 'json'
        data:
          product_id: product_id
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

      false

  filter_collection: ->
    $('#brand, #tier, #type, #band, #face, #width').bind 'change', ->
      $.ajax '/filter_collection',
        type: 'POST'
        data:
          brand: $('#brand').val()
          tier: $('#tier').val()
          type: $('#type').val()
          band: $('#band').val()
          face: $('#face').val()
          width: $('#width').val()
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->
          $('#listing-layout > .listing > .container').html(data)

  reset_collection: ->
    $('#reset_collection').bind 'click', ->
      $('#brand, #tier, #type, #band, #face, #width').val('')

default_shipping =
  init: ->
    $('.default-address').bind 'click', ->
      address_id = $(this).attr('data-address-id')

      $.ajax '/selected_shipping',
        type: 'POST'
        data:
          address_id: address_id
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->

save_rental_months =
  init: ->
    if $('#save_rental_months').length > 0
      $('#save_rental_months').bind 'click', ->
        arr = []
        $(".rental-months").each ->
          if $(this).attr("checked") == 'checked'
            arr.push($(this).val())

        if arr.length == 0
          alert('Select at lease one month')
        else
          $.ajax '/rental_months',
            type: 'POST'
            data:
              months: arr.join(',')
            error: (jqXHR, textStatus, errorThrown) ->
            success: (data, textStatus, jqXHR) ->
        false

login =
  init: ->
    $("a.login").click ->
      $("#signin-modal").dialog "open"

    this.catch_response()

  catch_response: ->
    $('#new_user').on 'ajax:success', (event, data, status, xhr) ->
      if data.success == false
        alert(data.errors.join('\n'))
      else
        window.location.reload()
signup =
  init: ->
    $('#user_signup').on 'ajax:before', (event, data, status, xhr) ->
      $('#join_button').hide()

    $('#user_signup').on 'ajax:success', (event, data, status, xhr) ->
      $('#join_button').show()

$ ->
  collection_list.init()
  default_shipping.init()
  save_rental_months.init()
  login.init()
  signup.init()
