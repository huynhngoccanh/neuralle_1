$(document).ready ->

  ### GENERAL ###

  # Set active tiles and icons
  setActiveTilesAndIcons = ->
    # $('#pricing radio:checked').closest('.plan-tile').addClass('active')
    $('#pricing input:checked').closest('label').addClass('active')
  setActiveTilesAndIcons()

  # Send subscription type form on click and update button
  $('#pricing-selector form').on 'change', ->
    $(@).submit()

  $('#pricing-selector .btn').on 'click', ->
    $(@).closest("#pricing-selector").find(".btn").removeClass("active")
    $(@).addClass("active")
    $('#pricing-table td').removeClass('active')
    if $(@).is('#once')
      $('#pricing-table .once').addClass('active')
    else
      $('#pricing-table .monthly').addClass('active')

  # Set active pricing perks
  setActivePricingPerks = ->
    if $('#pricing-selector #once').hasClass('active')
      $('#pricing-table .once').addClass('active')
    else
      $('#pricing-table .monthly').addClass('active')
  setActivePricingPerks()

  # Update prices and stages and re-enable forms on plan and subscription change
  $(document).ajaxSuccess (event, xhr, settings) ->
    if settings.url.includes('orders') || settings.url.includes('reset_order') || settings.url.includes('brief_request')
      enableSliders()
      setActiveTilesAndIcons()
      updateSliderHandles()
      # updateMgmtDistrTilesQuantity()
      toggleStages()

  $(document).ajaxSuccess (event, xhr, settings) ->
    if settings.url.includes('order_items')
      toggleStages()


  ### PLANS ###

  # Send plans form on click, update active tile, show/hide sliders
  # $(document).on 'change', '#plans-wrapper input[type="radio"]', ->
  #   $(@).closest('form').submit()
  #
  # $(document).on 'click', '#plans-wrapper .plan-tile', ->
  #   $(@).closest('#plans-wrapper').find('.plan-tile').removeClass("active")
  #   $(@).addClass("active")
  #
  #   if $(@).hasClass('customise')
  #     $('#podcast-production').slideDown()
  #     $('#content-production').slideDown()
  #   else
  #     $('#podcast-production').slideUp()
  #     $('#content-production').slideUp()
  #
  #   if $(@).hasClass('content')
  #     $('#rss-products').hide()
  #     $('#management-products .wrapper')
  #     .addClass('col-md-offset-3')
  #   else
  #     $('#rss-products').show()
  #     $('#management-products .wrapper')
  #     .removeClass('col-md-offset-3')
  #
  #   if $(@).hasClass('podcast')
  #     $('#rss-products input[type="number"]').val(4).trigger('change')


  ### SLIDERS ###

  # Enable sliders
  enableSliders = ->
    $('#pricing .product-slider').slider()
  enableSliders()

  # Update slider handles quantity on load
  updateSliderHandles = ->
    $("#pricing .slider-handle").each (i, handle) ->
      quantity = $(@).closest('form').find('input.product-slider').attr('data-slider-value')
      $(@).html("<p>" + quantity + "</p>")
  updateSliderHandles()

  # Send total podcasts quantity to RSS distribution
  sendPodcastsToRss = ->
    podcasts_quantity = 0
    $('#podcast-sliders input.product-slider').each (i, slider) ->
      podcasts_quantity += parseInt(slider.value)
    $('#rss-products input[type="number"]').val(podcasts_quantity).trigger('change')

  # Update slider handles quantity on slide
  $(document).on 'slideStop slide', '#pricing .product-slider', (e) ->
    price = parseInt($(@).attr("data-price"));
    total_price = e.value * price
    $(@).closest(".slider-wrapper").find(".slider-total").text("$ " + total_price)
    $(@).closest(".slider-wrapper").find(".slider-handle").html("<p>" + e.value + "</p>")
    # Update slider icons on change
    toggleSliderIcons()

  # Show sliders if the custom plan is selected
  # if $('.plan-tile.customise').find('input[type="radio"]').is(":checked")
  #   $('#podcast-production').show()
  #   $('#content-production').show()

  # Send sliders forms on slide release
  sliders = '#podcast-production .product-slider, #content-production .product-slider, #distribution-products .product-slider'
  $(document).on 'slideStop release', sliders, ->
    $(@).closest('form').submit()

    if $(@).closest('section').is('#podcast-production')
      sendPodcastsToRss()


  ### MGMT/DISTR ###

  # Show/hide rss tile
  # updateMgmtDistrTilesQuantity = ->
  #   if $('.plan-tile.content').find('input[type="radio"]').is(":checked")
  #     $('#rss-products').hide()
  #     $('#distribution-products .wrapper, #management-products .wrapper')
  #     .addClass('col-md-offset-3')
  #   else
  #     $('#rss-products').show()
  #     $('#distribution-products .wrapper, #management-products .wrapper')
  #     .removeClass('col-md-offset-3')
  # updateMgmtDistrTilesQuantity()

  # Calculate mgmt/distr total prices
  calculateTotal = (price, quantity) ->
    if !quantity || quantity == "0" || quantity == 0
      return "$ " + price * 1
    else
      total_cost = price * quantity
      return "$ " + total_cost

  # Update icons next to number fields
  toggleNumberFieldIcon = (e, quantity) ->
    if quantity > 0
      e.closest('form').find('.fa').addClass('active')
    else
      e.closest('form').find('.fa').removeClass('active')

  # Update icons next to slider fields
  toggleSliderIcons = ->
    $('#distribution-sliders .product-slider').each (i, slider) ->
      parseInt(slider.value)
      quantity = parseInt(slider.value)
      if quantity > 0
        $(@).closest('.slider-wrapper').find('.fa').addClass('active')
      else
        $(@).closest('.slider-wrapper').find('.fa').removeClass('active')
  toggleSliderIcons()

  # Send management and rss forms on change, update icnons and tiles
  $(document).on 'change', '#management-products input, #rss-products input', ->
    $(@).closest('form').submit()
    $(@).closest('label').toggleClass("active")

    price_value = $(@).closest('.product-tile').attr("data-price")

    if $(@).attr('type') == 'number'
      quantity_value = $(@).val()
      toggleNumberFieldIcon($(@), quantity_value)
    else
      quantity_value = $(@).closest('.product-tile').find('input:checked').length

    $(@).closest('.product-tile').find('.product-price').html(calculateTotal(price_value, quantity_value))


  ### DISCOUNT CODE ###

  oldValue = ""
  newValue = ""

  $(document).on 'focus', '#discount-code', ->
    oldValue = $(@).val()

  $(document).on 'blur', '#discount-code', ->
    newValue = $(@).val()
    if oldValue != newValue
      $(@).closest('form').submit()


  ### STAGES ###

  toggleStages = ->
    if $('#stages-wrapper').length
      stagesOffsetTop = $('#stages-wrapper').offset().top
      stagesHeight = $('#stages-wrapper').outerHeight()
      totalOffset = stagesOffsetTop + stagesHeight / 3 - 5
      if $(window).scrollTop() > totalOffset
        $('#stages').addClass('fixed')
        $('#stages-wrapper').addClass('fixed')
      else
        $('#stages').removeClass('fixed')
        $('#stages-wrapper').removeClass('fixed')

  toggleStages()
  $(window).on 'scroll', ->
    toggleStages()
