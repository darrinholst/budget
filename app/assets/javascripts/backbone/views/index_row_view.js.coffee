class BudgetApp.Views.IndexRowView extends BudgetApp.Views.BaseView
  template: JST['backbone/templates/index_row']
  tagName: 'div'
  className: 'row budget'

  initialize: (options = {}) ->
    super(options)
    $(@el).attr('id', @budget.cid)

  events:
    'click [data-delete-budget]': 'deleteBudget'
    'click': 'go'

  go: ->
    window.router.navigate(@$('a').attr('href'), true)

  deleteBudget: (e) ->
    e.stopPropagation()

    if confirm('Are you sure you want to delete this budget?')
      @budget.destroy()
      @remove()

  render: ->
    $(@el).html(@template(
      url: @budget.url()
      starts_on: @formatDate(@budget.startsOn())
      ends_on: @formatDate(@budget.endsOn())
      actual_balance: if @budget.inFuture() then '&mdash;' else @formatMoney(@budget.actualBalance())
      remaining: if @budget.inFuture() then '&mdash;' else @formatMoney(@budget.remaining())
      actual_buffer: if @budget.inFuture() then '&mdash;' else @formatMoney(@budget.actualBuffer())
    ))

    @
