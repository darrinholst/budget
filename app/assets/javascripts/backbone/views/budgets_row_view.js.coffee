class BudgetApp.Views.BudgetsRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets_row"]
  tagName: "div"
  className: "row-fluid"

  events: ->
    "click [data-edit-budget]": @edit

  edit: =>
    window.router.navigate("budgets/#{@model.id}", {trigger: true, replace: true})

  render: ->
    $(@el).html(@template(
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    return this
