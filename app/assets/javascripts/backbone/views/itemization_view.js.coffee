class BudgetApp.Views.ItemizationView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/itemization"]
  className: "row-fluid itemization"

  events:
    "change input[name=itemization_name]": "nameChanged"
    "change input[name=itemization_spent]": "spentChanged"
    "click [data-delete-itemization]": "deleteItemization"

  initialize: (options) ->
    super(options)
    @listenTo(@model, 'change:name', @renderName)
    @listenTo(@model, 'change:spent', @renderSpent)
    @listenTo(@model, 'focus:item', @focused)

  focused: ->
    @$("input[name=itemization_spent]").focus()

  nameChanged: (event) ->
    @model.name(@$("input[name=itemization_name]").val())
    @budget.save()

  renderName: ->
    @$("input[name=itemization_name]").val(@model.name())

  spentChanged: (event) ->
    @model.spent(@$("input[name=itemization_spent]").val())
    @budget.save()
    @model.get("bucket").trigger("change:itemizations")

  renderSpent: ->
    @$("input[name=itemization_spent]").val(@formatMoney(@model.spent()))

  deleteItemization: ->
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

