class BudgetApp.Views.BaseView extends Backbone.View
  initialize: (options = {}) ->
    super()
    @budget = options.budget
    @_childViews = []

  formatDate: (date) ->
    "#{@_pad(date.getUTCMonth() + 1, 2)}/#{@_pad(date.getUTCDate(), 2)}/#{date.getUTCFullYear()}"

  formatMoney: (cents) ->
    ((cents || 0) / 100).toFixed(2)

  _pad: (number, length) ->
    number = "#{number}"

    while number.length < length
      number = "0#{number}"

    number

  toggleCollapseCategory: ->
    @$(".buckets").toggle("slide")
    @$(".collapse-category").toggleClass("fa-angle-down").toggleClass("fa-angle-right")
    @model.set('collapsed', @$(".collapse-category").hasClass("fa-angle-right"))
    @budget.save()

  categoryIsCollapsed: ->
    @model.get('collapsed')

  close: ->
    @remove()
    childView.close() for childView in @_childViews

  newView: (clazz, options = {}) ->
    view = new clazz(options)
    @_childViews.push(view)
    view

