class BudgetApp.Views.IncomeView extends BudgetApp.Views.BaseView
  renderCategory: (category) ->
    view = @newView(BudgetApp.Views.IncomeCategoryView, model: category, budget: @budget)
    $(@el).append(view.render().el)

  render: ->
    @collection.each (category) => @renderCategory(category)
    @

