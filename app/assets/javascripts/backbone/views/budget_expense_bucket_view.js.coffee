class BudgetApp.Views.BudgetExpenseBucketView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_bucket"]
  className: "row-fluid bucket"

  render: ->
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    ))
    @
