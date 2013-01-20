class BudgetApp.Views.ItemizationView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/itemization"]
  className: "row-fluid itemization"

  events:
    "change input[name=name]": "nameChanged"
    "change input[name=spent]": "spentChanged"

  nameChanged: (event) =>
    event.stopPropagation()
    @model.name(@$("input[name=name]").val())
    @saveEm()

  spentChanged: (event) =>
    event.stopPropagation()
    @model.spent(@$("input[name=spent]").val())
    @saveEm()

  saveEm: ->
    bucket = @model.get("bucket")
    bucket.save(itemizations_attributes: bucket.itemizations().toJSON())

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      spent: @formatMoney(@model.spent())
    )).inlineEditable()
    @

