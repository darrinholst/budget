class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.Budgets()
    @budgets.reset window.budgets

  routes:
    "budgets"             : "listBudgets"
    "budgets/:id"         : "editBudget"
    "sandbox"             : "listSandboxBudgets"
    "sandbox/budgets/:id" : "editSandboxBudget"

  listSandboxBudgets: ->
    BudgetApp.localStorage = new Backbone.LocalStorage("budgets")
    @budgets.localStorage = BudgetApp.localStorage
    @listBudgets()

  editSandboxBudget: (id) ->
    $("#backbone").html(new BudgetApp.Views.BudgetView(model: @budgets.get(id) || @budgets.create()).render().el)

  listBudgets: ->
    $("#backbone").html(new BudgetApp.Views.BudgetsView(collection: @budgets).render().el)

  editBudget: (id) ->
    $("#backbone").html(new BudgetApp.Views.BudgetView(model: @budgets.get(id)).render().el)

$ ->
  if $("#backbone").length
    $(document).on "click", "a[data-push-state]", (e) ->
      e.preventDefault()
      window.router.navigate($(this).attr("href"), true)

    $(window).on "popstate", (e) ->
      window.router.navigate(location.pathname.substr(1), true)

    window.router = new BudgetApp.Routers.Router()
    Backbone.history.start(pushState: true)

