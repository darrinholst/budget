BudgetApp.Models.IncomeBucket = BudgetApp.Models.Bucket.extend
  defaults:
    name: "Name..."
    budgeted: 0

  initialize: ->
    @on "change", @triggerParentChange
    @on "remove", @triggerParentChange

  triggerParentChange: ->
    _.each(@getRelations(), (relation) -> relation.related && relation.related.trigger("change"))

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

  initialize: -> 
    @localStorage = BudgetApp.localStorage

  url: -> 
    "#{@.budget.url()}/incomes"

