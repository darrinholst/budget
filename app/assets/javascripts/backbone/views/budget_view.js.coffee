class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  render : ->
    $(@el).html(@template())
    @$("[data-categories-container]").append(new BudgetApp.Views.BudgetIncomeView(collection: @model.incomeBuckets()).render().el)
                                     .append(new BudgetApp.Views.BudgetExpensesView(collection: @model.expenseCategories()).render().el)
    @
