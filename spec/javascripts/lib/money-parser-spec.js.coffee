describe "Money Parser", ->
  it "parses money", ->
    expect($.parseMoney("2309.93")).toEqual(230993)

