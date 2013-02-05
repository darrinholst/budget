class BudgetApp.Views.ItemizationsView extends BudgetApp.Views.BaseView
  initialize: ->
    super()
    @collection.bind "focus", @focused
    @collection.bind "add", @itemizationAdded

  focused: =>
    @collection.last().trigger("focus:item")

  itemizationAdded: (itemization) =>
    @renderItemization(itemization)
    @focused()

  renderItemization: (itemization) =>
    view = new BudgetApp.Views.ItemizationView(model: itemization)
    $(@el).append(view.render().el)

  render: =>
    @collection.each (itemization) => @renderItemization(itemization)

