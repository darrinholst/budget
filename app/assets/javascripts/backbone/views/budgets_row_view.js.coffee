class BudgetApp.Views.BudgetsRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets_row"]
  tagName: "div"
  className: "row-fluid budget"

  events:
    "click [data-delete-budget]": "deleteBudget"

  deleteBudget: ->
    if confirm("Are you sure you want to delete this budget?")
      @model.destroy()
      @remove()

  render: ->
    $(@el).html(@template(
      url: "#{if BudgetApp.localStorage? then "/sandbox" else ""}#{@model.url()}"
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    @
