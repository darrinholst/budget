class BudgetApp.Models.IncomeBucket extends BudgetApp.Models.Bucket
  defaults:
    name: 'Name...'
    budgeted: 0

  save: (attributes, options) ->
    @collection.budget.save(attributes, options)

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

  initialize: (models, options) ->
    @budget = options.budget

