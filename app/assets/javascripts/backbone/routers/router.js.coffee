class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.BudgetsCollection()
    @budgets.reset window.budgets

  routes:
    ".*"          : "root"
    "budgets/:id" : "edit_budget"

  root: ->
    @view = new BudgetApp.Views.BudgetsView(budgets: @budgets)
    $("#app").html(@view.render().el)

  edit_budget: (id) ->
    budget = @budgets.get(id)
    @view = new BudgetApp.Views.BudgetView(model: budget)
    $("#app").html(@view.render().el)

$ ->
  $(document).on "click", "a", (e) ->
    e.preventDefault()
    window.router.navigate($(this).attr("href").substr(1), true)

  $(window).on "popstate", (e) ->
    window.router.navigate(location.pathname.substr(1), true)

  window.router = new BudgetApp.Routers.Router()
  Backbone.history.start(pushState: true)

