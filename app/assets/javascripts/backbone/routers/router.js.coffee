class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.BudgetsCollection()
    @budgets.fetch()

  routes:
    "/:id" : "edit"
    ".*"   : "index"

  index: ->
    @view = new BudgetApp.Views.BudgetsView(budgets: @budgets)
    $("#app").html(@view.render().el)

  edit: (id) ->
    budget = @budgets.get(id)
    @view = new BudgetApp.Views.BudgetView(model: budget)
    $("#app").html(@view.render().el)

$ ->
  window.router = new BudgetApp.Routers.Router()
  Backbone.history.start()
