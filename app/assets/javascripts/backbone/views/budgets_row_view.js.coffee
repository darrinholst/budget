class BudgetApp.Views.BudgetsRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets_row"]
  tagName: "div"
  className: "row-fluid"

  render: ->
    $(@el).html(@template(
      id: @model.id
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    return this
