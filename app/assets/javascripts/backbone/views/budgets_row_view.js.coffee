class BudgetApp.Views.BudgetsRowView extends Backbone.View
  template: JST["backbone/templates/budgets_row"]
  tagName: "tr"

  render: ->
    #TODO: decorator pattern here?
    $(@el).html(@template(
      id: @model.id
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      left_to_spend: @formatMoney(@model.leftToSpend())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    return this

  formatDate: (date) ->
    #TODO: Yuuuck, do something sane with dates
    "#{date.getUTCMonth() + 1}/#{date.getUTCDate()}/#{date.getUTCFullYear()}"

  formatMoney: (cents) ->
    ((cents || 0) / 100).toFixed(2)