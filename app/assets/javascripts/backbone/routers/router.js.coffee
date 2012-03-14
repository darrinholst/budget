class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.BudgetsCollection()
    @budgets.fetch()

  routes:
  #   "/new"      : "newBudget"
  #   "/index"    : "index"
  #   "/:id/edit" : "edit"
  #   "/:id"      : "show"
    ".*"        : "index"

  # newBudget: ->
  #   @view = new BudgetApp.Views.Budgets.NewView(collection: @budgets)
  #   $("#budgets").html(@view.render().el)

  index: ->
    @view = new BudgetApp.Views.Budgets.IndexView(budgets: @budgets)
    $("#app").html(@view.render().el)

  # show: (id) ->
  #   budget = @budgets.get(id)

  #   @view = new BudgetApp.Views.Budgets.ShowView(model: budget)
  #   $("#budgets").html(@view.render().el)

  # edit: (id) ->
  #   budget = @budgets.get(id)

  #   @view = new BudgetApp.Views.Budgets.EditView(model: budget)
  #   $("#budgets").html(@view.render().el)

$ ->
  window.router = new BudgetApp.Routers.Router()
  Backbone.history.start({pushState: true})
