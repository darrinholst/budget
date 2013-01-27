class BudgetApp.Views.ItemizationView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/itemization"]
  className: "row-fluid itemization"

  events:
    "change input[name=itemization_name]": "nameChanged"
    "change input[name=itemization_spent]": "spentChanged"
    "click [data-delete-itemization]": "deleteItemization"

  initialize: =>
    @model.bind "change:name", @renderName
    @model.bind "change:spent", @renderSpent

  nameChanged: (event) =>
    @model.name(@$("input[name=itemization_name]").val())
    @model.get("bucket").patch(itemizations_attributes: [@model.toJSON()])

  renderName: =>
    @$("input[name=itemization_name]").val(@model.name())

  spentChanged: (event) =>
    @model.spent(@$("input[name=itemization_spent]").val())
    @model.get("bucket").patch(itemizations_attributes: [@model.toJSON()])

  renderSpent: =>
    @$("input[name=itemization_spent]").val(@formatMoney(@model.spent()))

  deleteItemization: =>
    @model.get("bucket").patch(itemizations_attributes: [{id: @model.id, _destroy: true}])
    @remove()

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      spent: @formatMoney(@model.spent())
    )).inlineEditable()
    @

