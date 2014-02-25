class BudgetApp.Routers.Router extends Backbone.Router
  initialize: ->
    super()
    @budgets = new BudgetApp.Collections.Budgets()
    @budgets.fetch()

  routes:
    ""                    : "listBudgets"
    "budgets"             : "listBudgets"
    "budgets/:id"         : "editBudget"

  listBudgets: ->
    @_showView(new BudgetApp.Views.IndexView(collection: @budgets))

  editBudget: (id) ->
    budget = @budgets.get(id)
    @_showView(new BudgetApp.Views.BudgetView(model: budget))

  _showView: (view) ->
    @currentView.close() if @currentView && @currentView.close
    @currentView = view
    $("#backbone").html(@currentView.render().el)

$(document).on "click", "a[data-push-state]", (e) ->
  e.preventDefault()
  window.router.navigate($(this).attr("href"), true)

$(window).on "popstate", (e) ->
  window.router.navigate(location.pathname.substr(1), true)

