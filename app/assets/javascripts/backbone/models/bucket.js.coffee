class BudgetApp.Models.Bucket extends Backbone.Model
  defaults:
    name: 'Name...'
    budgeted: 0
    spent: 0

  parse: (response) ->
    itemizations = response.itemizations || []
    response.itemizations = new BudgetApp.Collections.Itemizations(itemizations, parse: true)
    response

  name: (newValue) ->
    if newValue?
      @set('name', newValue)
    else
      @get('name')

  budgeted: (newValue) ->
    if newValue?
      @set('budgeted', $.parseMoney(newValue))
    else
      @get('budgeted')

  spent: (newValue) ->
    if newValue?
      @set('spent', $.parseMoney(newValue))
    else
      if @itemizations().any() then @itemizations().spent() else @get('spent')

  remaining: ->
    @budgeted() - @spent()

  itemizations: (newValues) ->
    if newValues?
      @set('itemizations', newValues)
    else
      @get('itemizations') || new BudgetApp.Collections.Itemizations()

class BudgetApp.Collections.Buckets extends Backbone.Collection
  model: BudgetApp.Models.Bucket

  budgeted: ->
    @models.reduce ((memo, bucket) -> memo + bucket.budgeted()), 0

  spent: ->
    @models.reduce ((memo, bucket) -> memo + bucket.spent()), 0

  remaining: ->
    @models.reduce ((memo, bucket) -> memo + (if bucket.remaining() < 0 then 0 else bucket.remaining())), 0

  clear: ->
    @each (bucket) -> bucket.spent(0)

