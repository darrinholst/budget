$.parseMoney = (value) ->
  parseInt((parseFloat(value.replace(/,/g, ''), 10) * 100).toFixed())
