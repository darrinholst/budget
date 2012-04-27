(($) ->
  $.fn.spinTo = (newValue) ->
    difference = parseFloat(newValue) - parseFloat(@.val())
    console.log(difference)
    $(@).val(newValue)
)(jQuery)
