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
      @model.destroy()
      @remove()

  render: ->
    $(@el).html(@template(
      url: @model.url()
      starts_on: @formatDate(@model.startsOn())
      ends_on: @formatDate(@model.endsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    @
