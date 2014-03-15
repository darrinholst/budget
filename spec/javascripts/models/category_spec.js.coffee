describe 'BudgetApp.Models.Category', ->
  beforeEach ->
    @category = new BudgetApp.Models.Category({
      name: 'The Category'
      buckets: []
    }, parse: true)

  describe '#toJSON', ->
    it 'removes unused attributes', ->
      @category.set('foo', 'bar')

      json = @category.toJSON()

      expect(json.foo).toBeUndefined()

    it 'shortens attribute names', ->
      json = @category.toJSON()

      expect(json.n).toEqual(@category.name())
      expect(json.name).toBeUndefined()

  describe '#parse', ->
    it 'can parse results of toJSON', ->
      parsed = new BudgetApp.Models.Category(@category.toJSON(), parse: true)
      expect(parsed.name()).toEqual(@category.name())

