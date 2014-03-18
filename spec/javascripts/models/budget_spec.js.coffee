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

  describe '#percentComplete', ->
    it 'calculates percent complete on the first day', ->
      spyOn(Clock, 'now').and.returnValue(Date.parse('03/01/2014'))
      expect(@budget.percentComplete()).toEqual(0)

    it 'calculates percent complete on the last day', ->
      spyOn(Clock, 'now').and.returnValue(Date.parse('03/31/2014'))
      expect(@budget.percentComplete()).toEqual(97)

    it 'calculates percent complete in the middle', ->
      spyOn(Clock, 'now').and.returnValue(Date.parse('03/16/2014'))
      expect(@budget.percentComplete()).toEqual(48)

    it 'returns undefined if current date is after budget period', ->
      spyOn(Clock, 'now').and.returnValue(Date.parse('04/16/2014'))
      expect(@budget.percentComplete()).toBeUndefined()

    it 'returns undefined if current date is before budget period', ->
      spyOn(Clock, 'now').and.returnValue(Date.parse('02/16/2014'))
      expect(@budget.percentComplete()).toBeUndefined()

    it 'returns undefined if start date is not a date', ->
      @budget.startsOn('foo')
      spyOn(Clock, 'now').and.returnValue(Date.parse('03/16/2014'))
      expect(@budget.percentComplete()).toBeUndefined()

    it 'returns undefined if end date is not a date', ->
      @budget.endsOn('foo')
      spyOn(Clock, 'now').and.returnValue(Date.parse('03/16/2014'))
      expect(@budget.percentComplete()).toBeUndefined()

  describe '#toJSON', ->
    it 'removes unused attributes', ->
      @budget.set('foo', 'bar')

      json = @budget.toJSON()

      expect(json.foo).toBeNull()

    it 'shortens attribute names', ->
      json = @budget.toJSON()

      expect(json.ab).toEqual(@budget.actualBalance())
      expect(json.actual_balance).toBeNull()

  describe '#parse', ->
    it 'can parse results of toJSON', ->
      parsed = new BudgetApp.Models.Budget(@budget.toJSON(), parse: true)
      expect(parsed.actualBalance()).toEqual(@budget.actualBalance())


