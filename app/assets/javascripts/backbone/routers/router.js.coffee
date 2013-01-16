class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    @budgets = new BudgetApp.Collections.Budgets()
    @budgets.reset window.budgets

  routes:
    "budgets"             : "listBudgets"
    "sandbox/budgets"     : "listBudgets"
    "shared/:token"       : "showBudget"
    "budgets/:id"         : "editBudget"
    "sandbox/budgets/:id" : "editBudget"

  showBudget: ->
    budget = @budgets.first()
    $("#backbone").html(new BudgetApp.Views.BudgetView(model: budget, readonly: true).render().el)

  listBudgets: ->
    if(window.localStorageEnabled)
      BudgetApp.localStorage = new Backbone.LocalStorage("budgets")
      @budgets.localStorage = BudgetApp.localStorage

    $("#backbone").html(new BudgetApp.Views.IndexView(collection: @budgets).render().el)

  editBudget: (id) ->
    budget = @budgets.get(id)

    if window.localStorage and !budget
      budget = @budgets.create()

    $("#backbone").html(new BudgetApp.Views.BudgetView(model: budget).render().el)

$ ->
  if $("#backbone").length
    $(document).on "click", "a[data-push-state]", (e) ->
      e.preventDefault()
      window.router.navigate($(this).attr("href"), true)

    $(window).on "popstate", (e) ->
      window.router.navigate(location.pathname.substr(1), true)

    window.router = new BudgetApp.Routers.Router()
    Backbone.history.start(pushState: true)

