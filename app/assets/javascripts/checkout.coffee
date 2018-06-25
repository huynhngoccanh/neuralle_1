$(document).ready ->

  $(document).on 'change', '#checkout #brief-form input', ->
    $(@).closest('form').submit()

  $(document).on 'change', '#checkout #brief-form textarea', ->
    $(@).closest('form').submit()

  $(document).on 'change', '#checkout #brief-form select', ->
    $(@).closest('form').submit()
