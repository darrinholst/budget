class BudgetApp.Views.BudgetsRowView extends Backbone.View
  template: JST["backbone/templates/budgets_row"]
  tagName: "tr"

  render: ->
    $(@el).html(@template(
      id: @model.id
      starts_on: @model.get("starts_on")
      actual_balance: $M(@model.get("actual_balance"))
      left_to_spend: $M(@model.get("left_to_spend"))
      actual_buffer: $M(@model.get("actual_buffer"))
    ))

    return this

  $M = (cents) ->
    ((cents || 0) / 100).toFixed(2)
