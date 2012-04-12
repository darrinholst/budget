class BudgetApp.Views.BudgetsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets"]
  className: "budgets"

  events: ->
    "click [data-add-budget]": @addNew

  initialize: ->
    @collection.bind('reset', @addAll)

  addNew: =>
    @collection.add({})
    budget = @collection.last()
    budget.save()
    @renderBudget(budget)

  renderBudget: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({collection: @collection, model : budget})
    @$(".row-fluid:last").before(view.render().el)

  addAll: =>
    @collection.each(@renderBudget)

  render: =>
    $(@el).html(@template())
    @addAll()
    @

