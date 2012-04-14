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

  # dateChanged: =>
  #   @model.startsOn(@$("[name=starts_on]").trigger("blur").val())

  #   @model.save({},
  #     success: =>
  #       @collection.trigger("reorder")
  #   )

  # actualBalanceChanged: ->
  #   @model.actualBalance(@$("[name=actual_balance]").val())
  #   @model.save({},
  #     success: =>
  #       @$("[name=actual_balance]").val(@formatMoney(@model.actualBalance()))
  #       @$("#actual-buffer").html(@formatMoney(@model.actualBuffer()))
  #   )

  render: ->
    $(@el).html(@template(
      id: @model.id
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    @
