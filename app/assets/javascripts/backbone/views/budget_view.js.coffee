class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  events:
    "change input": "save"
    "change": "render"

  save: ->
    @model.actualBalance(@$("input[name=actual]").val())

  render : (event) ->
    $(@el).html(@template(
      total_income: @formatMoney(@model.totalIncome())
      total_expenses: @formatMoney(@model.totalExpenses())
      budgeted_buffer: @formatMoney(@model.budgetedBuffer())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    )).inlineEditable()

    @$("[data-categories-container]").append(new BudgetApp.Views.BudgetIncomeView(collection: @model.incomeBuckets()).render().el)
                                     .append(new BudgetApp.Views.BudgetExpensesView(collection: @model.expenseCategories()).render().el)
    @
