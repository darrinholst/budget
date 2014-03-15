describe 'BudgetApp.Models.Bucket', ->
  beforeEach ->
    @bucket = new BudgetApp.Models.Bucket({
      name: 'Mortgage'
      budgeted: '100'
    }, parse: true)

  describe '#toJSON', ->
    it 'removes unused attributes', ->
      @bucket.set('foo', 'bar')

      json = @bucket.toJSON()

      expect(json.foo).toBeUndefined()

    it 'shortens attribute names', ->
      json = @bucket.toJSON()

      expect(json.n).toEqual(@bucket.name())
      expect(json.name).toBeUndefined()

  describe '#parse', ->
    it 'can parse results of toJSON', ->
      parsed = new BudgetApp.Models.Bucket(@bucket.toJSON(), parse: true)
      expect(parsed.name()).toEqual(@bucket.name())

