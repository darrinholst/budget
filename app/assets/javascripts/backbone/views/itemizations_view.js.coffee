class BudgetApp.Views.ItemizationsView extends BudgetApp.Views.BaseView
  initialize: ->
    super()
    @listenTo(@collection, "focus", @focused)
    @listenTo(@collection, "add", @itemizationAdded)

  focused: =>
    @collection.last().trigger("focus:item")

  itemizationAdded: (itemization) =>
    @renderItemization(itemization)
    @focused()

  renderItemization: (itemization) =>
    view = @newView(BudgetApp.Views.ItemizationView, model: itemization)
    $(@el).append(view.render().el)

  render: =>
    @collection.each (itemization) => @renderItemization(itemization)

