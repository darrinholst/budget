BudgetApp.Models.Itemization = Backbone.RelationalModel.extend
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
    "#{@bucket.url()}/itemizations"

  spent: ->
    @models.reduce ((memo, item) -> memo + item.spent()), 0

