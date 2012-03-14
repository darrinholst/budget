BudgetApp.Views.Budgets ||= {}

class BudgetApp.Views.Budgets.EditView extends Backbone.View
  template : JST["backbone/templates/budgets/edit"]

  events :
    "submit #edit-budget" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (budget) =>
        @model = budget
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
