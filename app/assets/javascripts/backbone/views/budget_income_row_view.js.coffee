class BudgetApp.Views.BudgetIncomeRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income_row"]
  className: "row-fluid bucket"

  events:
    "change input": "save"

  save: ->
    @model.name(@$("input[name=name]").val())
    @model.budgeted(@$("input[name=budgeted]").val())

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      budgeted: @formatMoney(@model.budgeted())
    )).inlineEditable()
    @
