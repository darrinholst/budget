class BudgetApp.Models.Budget extends Backbone.Model
  paramRoot: 'budget'

  defaults:
    starts_on: ""

class BudgetApp.Collections.BudgetsCollection extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: '/budgets'
