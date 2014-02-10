class BudgetApp.Views.OverviewView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/overview"]
  className: "overview container-fluid"

  events:
    "change input[name=actual]": "actualChanged"
    "change input[name=starts_on]": "startsOnChanged"
    "changeDate": -> @$("input[name=starts_on]").blur().trigger("change")

  initialize: ->
    super()
    @listenTo(@model, 'change', @render)
    $(document).bind('keydown', 'ctrl+b', @focusActualBalance)

  close: ->
    super()
    $(document).unbind('keydown', null, @focusActualBalance)

  focusActualBalance: =>
    @$("input[name=actual]").focus()

  actualChanged: ->
    @model.actualBalance(@$("input[name=actual]").val())
    @model.save()

  startsOnChanged: ->
    @model.startsOn(@$("input[name=starts_on]").val())
    @model.save()

  render : (event) ->
    $(@el).html(@template(
      starts_on: @formatDate(@model.startsOn())
      total_income: @formatMoney(@model.totalIncome())
      total_expenses: @formatMoney(@model.totalExpenses())
      budgeted_buffer: @formatMoney(@model.budgetedBuffer())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    )).inlineEditable()

    @$("input[name=starts_on]").datepicker()

    @
