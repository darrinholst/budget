$(document).ajaxSend ->
  $("#activity").show()

$(document).ajaxComplete ->
  $("#activity").hide()

