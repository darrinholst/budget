class BudgetApp.Views.ItemizationsView extends BudgetApp.Views.BaseView
  initialize: (options) ->
    super(options)
    @listenTo(@collection, 'focus', @focused)
    @listenTo(@collection, 'add', @itemizationAdded)
    @listenTo(@collection, 'destroy', @itemizationRemoved)

  focused: ->
    @collection.last().trigger('focus:item')

  itemizationAdded: (itemization) ->
    @renderItemization(itemization)
    @budget.save()
    @focused()

  itemizationRemoved: ->
    @budget.save()
    @triggerChange()

  triggerChange: ->
    @collection.parent.trigger('change:itemizations')

  renderItemization: (itemization) ->
    view = @newView(BudgetApp.Views.ItemizationView, model: itemization, budget: @budget)
    $(@el).append(view.render().el)

  render: ->
    @collection.each (itemization) => @renderItemization(itemization)

