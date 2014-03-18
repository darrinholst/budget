describe 'BudgetApp.Models.Category', ->
  beforeEach ->
    @category = new BudgetApp.Models.Category({
      name: 'The Category'
      buckets: []
    }, parse: true)

  describe '#percentSpent', ->
    it 'calculates it when no buckets', ->
      expect(@category.percentSpent()).toEqual(0)

    it 'calculates it when spent < budgeted', ->
      @category.buckets().add(new BudgetApp.Models.Bucket(budgeted: 10000, spent: 5100))
      expect(@category.percentSpent()).toEqual(51)

    it 'calculates it when spent > budgeted', ->
      @category.buckets().add(new BudgetApp.Models.Bucket(budgeted: 10000, spent: 15000))
      expect(@category.percentSpent()).toEqual(150)

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

