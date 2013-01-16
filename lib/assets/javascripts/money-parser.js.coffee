$.parseMoney = (value) ->
  (parseFloat(value, 10) * 100).toFixed()
