describe 'BudgetApp.Models.Budget', ->
  beforeEach ->
    @budget = new BudgetApp.Models.Budget({
      id: 'some id'
      actual_balance: '100001'
      starts_on: '03/01/2014'
      ends_on: '03/31/2014'
      income_buckets: JSON.stringify([
        {budgeted: 100000}
      ])
      categories: JSON.stringify([
        {buckets: [{budgeted: 40000, spent: 20000}]},
        {buckets: [{budgeted: 30000, spent: 10000}]}
      ])
    }, parse: true)

  it 'can clone itself', ->
    cloned = @budget.clone()

    expect(cloned.get('id')).toBeUndefined()
    expect(cloned.startsOn()).toEqual(Date.parse('03/01/2014'))
    expect(cloned.endsOn()).toEqual(Date.parse('03/31/2014'))
    expect(cloned.totalIncome()).toEqual(100000)
    expect(cloned.totalExpenses()).toEqual(70000)
    expect(cloned.expenseCategories().remaining()).toEqual(40000)

  it 'can clear itself', ->
    @budget.clear()

    expect(@budget.actualBalance()).toEqual(0)
    expect(@budget.expenseCategories().remaining()).toEqual(70000)

  describe '#toJSON', ->
    it 'removes unused attributes', ->
      @budget.set('foo', 'bar')

      json = @budget.toJSON()

      expect(json.id).toEqual('some id')
      expect(json.foo).toBeNull()

    it 'shortens attribute names', ->
      json = @budget.toJSON()

      expect(json.ab).toEqual(@budget.actualBalance())
      expect(json.actual_balance).toBeNull()

  describe '#parse', ->
    it 'can parse results of toJSON', ->
      parsed = new BudgetApp.Models.Budget(@budget.toJSON(), parse: true)
      expect(parsed.actualBalance()).toEqual(@budget.actualBalance())


