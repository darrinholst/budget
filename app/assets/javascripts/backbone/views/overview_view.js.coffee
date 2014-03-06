class BudgetApp.Views.OverviewView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/overview"]
  className: "overview container-fluid"

  events:
    "change input[name=actual]": "actualChanged"
    "change input[name=starts_on]": "startsOnChanged"
    "change input[name=ends_on]": "endsOnChanged"
    'changeDate input[name=starts_on]': -> @$("input[name=starts_on]").blur().trigger("change")
    'changeDate input[name=ends_on]': -> @$("input[name=ends_on]").blur().trigger("change")

  initialize: (options) ->
    super(options)
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

  endsOnChanged: ->
    @model.endsOn(@$("input[name=ends_on]").val())
    @model.save()

  render : (event) ->
    $(@el).html(@template(
      starts_on: @formatDate(@model.startsOn())
      ends_on: @formatDate(@model.endsOn())
      total_income: @formatMoney(@model.totalIncome())
      total_expenses: @formatMoney(@model.totalExpenses())
      budgeted_buffer: @formatMoney(@model.budgetedBuffer())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    )).inlineEditable()

    @$("input[name=starts_on], input[name=ends_on]").datepicker()

    @
