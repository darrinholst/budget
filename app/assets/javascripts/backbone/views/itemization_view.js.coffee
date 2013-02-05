class BudgetApp.Views.ItemizationView extends BudgetApp.Views.BaseView
  relations: [
    {
      type: Backbone.HasMany
      key: 'itemizations'
      relatedModel: 'BudgetApp.Models.Itemization'
      collectionType: 'BudgetApp.Collections.Itemizations'
      includeInJSON: false
      reverseRelation:
        key: 'bucket'
        includeInJSON: false
    }
  ]

  template: JST["backbone/templates/itemization"]
  className: "row-fluid itemization"

  events:
    "change input[name=itemization_name]": "nameChanged"
    "change input[name=itemization_spent]": "spentChanged"
    "click [data-delete-itemization]": "deleteItemization"

  initialize: =>
    @model.bind "change:name", @renderName
    @model.bind "change:spent", @renderSpent
    @model.bind "focus:item", @focused

  focused: =>
    @$("input[name=itemization_spent]").focus()

  nameChanged: (event) =>
    @model.name(@$("input[name=itemization_name]").val())
    @model.patch(name: @model.name())

  renderName: =>
    @$("input[name=itemization_name]").val(@model.name())

  spentChanged: (event) =>
    @model.spent(@$("input[name=itemization_spent]").val())
    @model.patch(spent: @model.spent())
    @model.get("bucket").trigger("change:itemizations")

  renderSpent: =>
    @$("input[name=itemization_spent]").val(@formatMoney(@model.spent()))

  deleteItemization: =>
    if confirm("Are you sure?")
      bucket = @model.get("bucket")
      @model.destroy()
      @remove()
      bucket.trigger("change:itemizations")

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      spent: @formatMoney(@model.spent())
    )).inlineEditable()
    @

