class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.Budgets()
    @budgets.reset window.budgets

  routes:
    ".*"          : "root"
    "budgets/:id" : "edit_budget"

  root: ->
    $("#app").html(new BudgetApp.Views.BudgetsView(collection: @budgets).render().el)

  edit_budget: (id) ->
    $("#app").html(new BudgetApp.Views.BudgetView(model: @budgets.get(id)).render().el)

$ ->
  $(document).on "click", "a", (e) ->
    route = $(this).attr("href")

    unless route == "#"
      e.preventDefault()
      window.router.navigate(route.substr(1), true)

  $(document).on "click", "a", (e) ->
    e.preventDefault()

  $(window).on "popstate", (e) ->
    window.router.navigate(location.pathname.substr(1), true)

  window.router = new BudgetApp.Routers.Router()
  Backbone.history.start(pushState: true)

