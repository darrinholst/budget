class BudgetApp.Views.ExpensesView extends BudgetApp.Views.BaseView
  template: JST['backbone/templates/expenses']
  className: 'expenses'

  events:
    'click [data-add-category]': 'addNewCategory'
    'sortupdate .categories': 'updateSortOrder'

  initialize: (options) ->
    super(options)
    @listenTo(@collection, 'add', @newCategoryAdded)
    @listenTo(@collection, 'destroy', @categoryRemoved)

  updateSortOrder: ->
    ids = ($(el).data('view').model.cid for el in @$('.category-wrapper'))
    @collection.models = @collection.sortBy((category) -> ids.indexOf(category.cid))
    @budget.save()

  addNewCategory: ->
    @collection.add({}, parse: true)

  newCategoryAdded: (category) ->
    @budget.save({},
      success: =>
        @renderCategory(category, true)
        @updateSortOrder()

      error: =>
        alert('Couldn\'t save new category')
    )

  categoryRemoved: ->
    @budget.save()

  renderCategory: (category, focus) ->
    view = @newView(BudgetApp.Views.ExpenseCategoryView, model: category, budget: @budget)
    @$('.categories').append(view.render().el)
    $(view.el).find('input[name=name]').focus() if focus
    $(view.el).data('view', view)

  render: ->
    $(@el).html(@template())
    @collection.each (category) => @renderCategory(category)
    @$('.categories').sortable(axis: 'y')
    @

