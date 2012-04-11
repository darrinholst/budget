class BudgetApp.Views.BudgetsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets"]

  events: ->
    "click [data-add-budget]": @addNew

  initialize: ->
    @collection.bind('reset', @addAll)

  addNew: =>
    budget = new BudgetApp.Models.Budget()
    @addOne(budget)

  addOne: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({collection: @collection, model : budget})
    @$("tbody").append(view.render().el)

  addAll: =>
    @collection.each(@addOne)

  render: =>
    $(@el).html(@template(budgets: @collection.toJSON()))
    @addAll()
    this
