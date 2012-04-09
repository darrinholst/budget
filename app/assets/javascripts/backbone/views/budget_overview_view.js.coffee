class BudgetApp.Views.BudgetOverviewView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_overview"]
  className: "overview container-fluid"

  events:
    "change input[name=actual]": -> @model.actualBalance(@$("input[name=actual]").val())

  initialize: ->
    @model.bind("change", @sync)

  sync: =>
    @model.save()
    @render()

  render : (event) ->
    $(@el).html(@template(
      total_income: @formatMoney(@model.totalIncome())
      total_expenses: @formatMoney(@model.totalExpenses())
      budgeted_buffer: @formatMoney(@model.budgetedBuffer())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    )).inlineEditable()

    @
