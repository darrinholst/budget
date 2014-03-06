class BudgetApp.Views.IndexRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/index_row"]
  tagName: "div"
  className: "row-fluid budget"

  events:
    "click [data-delete-budget]": "deleteBudget"
    "click": "go"

  go: ->
    window.router.navigate(@$("a").attr("href"), true)

  deleteBudget: ->
    if confirm("Are you sure you want to delete this budget?")
      @budget.destroy()
      @remove()

  render: ->
    $(@el).html(@template(
      url: @budget.url()
      starts_on: @formatDate(@budget.startsOn())
      ends_on: @formatDate(@budget.endsOn())
      actual_balance: @formatMoney(@budget.actualBalance())
      remaining: @formatMoney(@budget.remaining())
      actual_buffer: @formatMoney(@budget.actualBuffer())
    ))

    @
