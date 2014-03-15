describe 'BudgetApp.Models.Itemization', ->
  beforeEach ->
    @itemization = new BudgetApp.Models.Itemization({
      name: 'McDonalds'
      spent: '100'
    }, parse: true)

  describe '#toJSON', ->
    it 'removes unused attributes', ->
      @itemization.set('foo', 'bar')

      json = @itemization.toJSON()

      expect(json.foo).toBeUndefined()

    it 'shortens attribute names', ->
      json = @itemization.toJSON()

      expect(json.n).toEqual(@itemization.name())
      expect(json.name).toBeUndefined()

  describe '#parse', ->
    it 'can parse results of toJSON', ->
      parsed = new BudgetApp.Models.Itemization(@itemization.toJSON(), parse: true)
      expect(parsed.name()).toEqual(@itemization.name())

