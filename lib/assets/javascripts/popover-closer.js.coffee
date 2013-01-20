$(document).on 'click', '[data-close-popover]', (event) ->
  $(this).parents(".popover").hide()

