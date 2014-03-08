describe 'Money Parser', ->
  it 'parses a string into cents', ->
    expect($.parseMoney('2309.93')).toEqual(230993)

  it 'parses a string with commas into cents', ->
    expect($.parseMoney('2,309.93')).toEqual(230993)

  it 'parses an integer into cents', ->
    expect($.parseMoney(100)).toEqual(10000)

  it 'parses a float into cents', ->
    expect($.parseMoney(100.50)).toEqual(10050)
