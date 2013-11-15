describe "Money Parser", ->
  it "parses money", ->
    expect($.parseMoney("2309.93")).toEqual(230993)

  it "parses commas", ->
    expect($.parseMoney("2,309.93")).toEqual(230993)

  it "parses numbers", ->
    expect($.parseMoney(0)).toEqual(0)

