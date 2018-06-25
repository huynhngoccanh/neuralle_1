$(document).ready ->

  placeholderWidth = $('#what img:first').width()
  $('.pricing-btn').attr('width', "#{placeholderWidth}px")

  $('#faq-toggle').on 'click', ->
    $(@).slideUp(50)
    $('#faq').slideDown(300)

  $('#media #slider').on 'mouseover', ->
    $(@).addClass('focus')
