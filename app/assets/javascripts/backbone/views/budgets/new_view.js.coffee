BudgetApp.Views.Budgets ||= {}

class BudgetApp.Views.Budgets.NewView extends Backbone.View
  template: JST["backbone/templates/budgets/new"]

  events:
    "submit #new-budget": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (budget) =>
        @model = budget
        window.location.hash = "/#{@model.id}"

      error: (budget, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
