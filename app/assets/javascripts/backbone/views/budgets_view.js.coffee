class BudgetApp.Views.IndexView extends BudgetApp.Views.BaseView
  template: JST['backbone/templates/index']
  className: 'budgets'

  events: ->
    'click .modal-footer .btn-success': 'addBudget'
    'click .modal-footer .btn-cancel': 'closeModal'
    'shown #addBudget': 'showModal'
    'changeDate': => @$('#starts_on, #ends_on').blur()

  initialize: ->
    super()
    @listenTo(@collection, 'add', @newBudgetAdded)
    $(document).bind('keydown', 'j', @selectNext)
    $(document).bind('keydown', 'k', @selectPrevious)
    $(document).bind('keydown', 'return', @openSelected)
    $(document).bind('keydown', 'o', @openSelected)

  close: ->
    super()
    $(document).unbind('keydown', null, @selectNext)
    $(document).unbind('keydown', null, @selectPrevious)
    $(document).unbind('keydown', null, @openSelected)

  selectNext: =>
    if @$('.budget.selected').next('.budget').length
      @$('.budget.selected').removeClass('selected').next('.budget').addClass('selected')

  selectPrevious: =>
    if @$('.budget.selected').prev('.budget').length
      @$('.budget.selected').removeClass('selected').prev('.budget').addClass('selected')

  openSelected: =>
    window.router.navigate(@$(".selected a").attr("href"), true)

  addBudget: =>
    if $('[name=from]:checked').val() == 'clone'
      newBudget = @collection.get(@$('#from_selection').val()).clone()
      newBudget.clear()
      newBudget.startsOn(@$('#starts_on').val())
      newBudget.endsOn(@$('#ends_on').val())
      @collection.add(newBudget)
    else
      @collection.add({starts_on: @$('#starts_on').val(), ends_on: @$('#ends_on').val()})

    @closeModal()

  showModal: =>
    @$('#starts_on').val(@formatDate(new Date())).datepicker()
    @$('#ends_on').val(@formatDate(new Date())).datepicker()

    if @collection.length
      @$('#from_clone').attr('disabled', false).attr('checked', true)
      options = @$('#from_selection')[0].options
      options.length = 0
      options.add(new Option(@formatDate(budget.startsOn()), budget.id)) for budget in @collection.models
    else
      @$('#from_clone').attr('disabled', true).attr('checked', false)
      @$('#from_scratch').attr('checked', true)

  closeModal: =>
    @$('#addBudget').modal('hide')

  newBudgetAdded: (budget) =>
    budget.save({},
      success: (budget) =>
        @closeModal()
        @render()

      error: =>
        @closeModal()
        alert('Couldn\'t save new budget')
    )

  renderBudget: (budget) =>
    view = @newView(BudgetApp.Views.IndexRowView, {collection: @collection, budget: budget})
    @$('.row-fluid:last').before(view.render().el)

  addAll: ->
    @collection.each(@renderBudget)

  render: ->
    $(@el).html(@template())
    @addAll()
    $('.nav.budget-list').hide()
    @$('.budget:first').addClass('selected')
    @

