$ ->

  shrinkNavbar = ->
    if $(@).scrollTop() > 0
      $('#header').addClass('shrinked')
      if $('#site_bar').length
        $('header#header').addClass('site-bar-scrolled')
    else
      $('#header').removeClass('shrinked')
      if $('#site_bar').length
        $('header#header').removeClass('site-bar-scrolled')

  isNotHomepage =->
    $('.pages_page.home_action').length == 0

  isNotBlogPage =->
    $('.posts_page.blog').length == 0

  isNotPodcastPage =->
    $('.pages_page.podcast').length == 0

  # if(isNotHomepage() && isNotBlogPage() && isNotPodcastPage())
  shrinkNavbar()

  $(window).scroll ->
    shrinkNavbar()
