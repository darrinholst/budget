class BudgetApp.Views.BudgetIncomeRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income_row"]
  className: "row-fluid bucket"

  render: ->
    $(@el).html(@template(name: @model.name(), budgeted: @formatMoney(@model.budgeted())))
    @
