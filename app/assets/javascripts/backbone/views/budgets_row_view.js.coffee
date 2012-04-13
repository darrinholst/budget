class BudgetApp.Views.BudgetsRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets_row"]
  tagName: "div"
  className: "row-fluid"

  events:
    "changeDate": "dateChanged"
    "change [name=starts_on]": "dateChanged"
    "change [name=actual_balance]": "actualBalanceChanged"

  dateChanged: ->
    @model.startsOn(@$("[name=starts_on]").trigger("blur").val())
    @model.save()

  actualBalanceChanged: ->
    @model.actualBalance(@$("[name=actual_balance]").val())
    @model.save({}, 
      success: => 
        @$("[name=actual_balance]").val(@formatMoney(@model.actualBalance()))
        @$("#actual-buffer").html(@formatMoney(@model.actualBuffer()))
    )

  render: ->
    $(@el).html(@template(
      id: @model.id
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    )).inlineEditable()

    @$("[name=starts_on]").datepicker()
    @
