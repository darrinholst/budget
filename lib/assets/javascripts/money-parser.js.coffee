$.parseMoney = (value) ->
  parseInt((parseFloat(value, 10) * 100).toFixed())
