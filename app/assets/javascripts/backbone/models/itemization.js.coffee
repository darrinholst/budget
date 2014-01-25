BudgetApp.Models.Itemization = BudgetApp.Models.BaseModel.extend
  defaults:
    name: "Name..."
    spent: 0

  name: (newValue) ->
    if newValue?
      @set("name", newValue)
    else
      @get("name")

  spent: (newValue) ->
    if newValue?
      @set("spent", $.parseMoney(newValue))
    else
      @get("spent")

class BudgetApp.Collections.Itemizations extends Backbone.Collection
  model: BudgetApp.Models.Itemization

  initialize: ->
    @localStorage = BudgetApp.localStorage

  url: ->
    "/buckets/#{@bucket.id}/itemizations"

  spent: ->
    @models.reduce ((memo, item) -> memo + item.spent()), 0

