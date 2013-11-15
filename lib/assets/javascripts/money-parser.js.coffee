$.parseMoney = (value) ->
  valueAsString = ('' + value).replace(/,/g, '')
  valueAsFloat = parseFloat(valueAsString, 10) * 100
  parseInt(valueAsFloat.toFixed())

