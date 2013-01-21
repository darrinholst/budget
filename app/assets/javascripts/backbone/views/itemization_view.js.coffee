class BudgetApp.Views.ItemizationView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/itemization"]
  className: "row-fluid itemization"

  events:
    "change input[name=itemization_name]": "nameChanged"
    "change input[name=itemization_spent]": "spentChanged"

  nameChanged: (event) =>
    @model.name(@$("input[name=itemization_name]").val())
    @model.get("bucket").save(itemizations_attributes: [@model.toJSON()])

  spentChanged: (event) =>
    @model.spent(@$("input[name=itemization_spent]").val())
    @model.get("bucket").save(itemizations_attributes: [@model.toJSON()])

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      spent: @formatMoney(@model.spent())
    )).inlineEditable()
    @

