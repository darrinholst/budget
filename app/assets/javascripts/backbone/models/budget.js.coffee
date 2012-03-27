class BudgetApp.Models.Budget extends Backbone.Model
  paramRoot: 'budget'

  defaults: {
    actual_balance: 0
  }

  initialize: (json) ->
    @categories = new BudgetApp.Collections.Categories()
    @categories.reset json.categories
    @set("starts_on", new Date(Date.parse(@get("starts_on"))))

  startsOn: ->
    @get("starts_on")

  actualBalance: ->
    @get("actual_balance")

  leftToSpend: ->
    @categories.leftToSpend()

  actualBuffer: ->
    @actualBalance() - @leftToSpend()

class BudgetApp.Collections.Budgets extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: '/budgets'
