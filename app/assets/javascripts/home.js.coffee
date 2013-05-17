
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
             $('.modal').modal('hide');
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
        console.log("balls")
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

