class BudgetApp.Views.BudgetExpensesView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expenses"]
  className: "expenses"

  addCategory: (category) =>
    $(@el).append(new BudgetApp.Views.BudgetExpenseCategoryView(model: category).render().el)

  render: ->
    $(@el).html(@template())
    @collection.each(@addCategory)
    $(@el).sortable(axis: "y")
    @
