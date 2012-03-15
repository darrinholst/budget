class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.BudgetsCollection()
    @budgets.reset window.budgets

  routes:
    "/:id" : "edit_budget"
    ".*"   : "root"

  root: ->
    @view = new BudgetApp.Views.BudgetsView(budgets: @budgets)
    $("#app").html(@view.render().el)

  edit_budget: (id) ->
    budget = @budgets.get(id)
    @view = new BudgetApp.Views.BudgetView(model: budget)
    $("#app").html(@view.render().el)

$ ->
  window.router = new BudgetApp.Routers.Router()
  Backbone.history.start()
