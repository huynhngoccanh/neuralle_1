$(document).ready ->

  $('.testimonials-carousel').owlCarousel({
    singleItem: true,
    loop: true,
    autoPlay: true,
    stopOnHover: true,
    pagination: true
  })

  $('.media-carousel').owlCarousel({
    singleItem: true,
    loop: true,
    autoPlay: true,
    stopOnHover: true,
    pagination: true
  })

  $('.media-carousel .item').removeClass('hide')
