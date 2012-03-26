class BudgetApp.Models.Budget extends Backbone.Model
  paramRoot: 'budget'

  initialize: (json) ->
    @categories = new BudgetApp.Collections.Categories()
    @categories.reset json.categories

class BudgetApp.Collections.Budgets extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: '/budgets'