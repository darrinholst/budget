class BudgetApp.Views.ExpenseBucketView extends BudgetApp.Views.BaseBucketView
  template: JST["backbone/templates/expense_bucket"]

  events: ->
    _.extend super(), {
      "change input[name=spent]": "spentChanged"
      "click [data-itemize-bucket]": "itemizeBucket"
    }

  initialize: ->
    super()
    @model.bind "change:spent", @renderSpent
    @model.bind "change:itemizations", @renderSpent

  spentChanged: (event) =>
    @model.spent(event.target.value)
    @model.patch(spent: @model.spent())

  renderSpent: =>
    @$("input[name=spent]").val(@formatMoney(@model.spent()))
    @$("input[name=remaining]").val(@formatMoney(@model.remaining()))

  itemizeBucket: ->
    @renderItemization new BudgetApp.Models.Itemization(bucket: @model)

  renderItemization: (itemization) =>
    view = new BudgetApp.Views.ItemizationView(model: itemization)
    @$(".itemizations").append(view.render().el)

  render: =>
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

    @model.itemizations().each (itemization) => @renderItemization(itemization)

    @colorize()

    @

