class BudgetApp.Views.IndexView extends BudgetApp.Views.BaseView
  template: JST['backbone/templates/index']
  className: 'budgets'

  events: ->
    'click .modal-footer .btn-success': 'addBudget'
    'click .modal-footer .btn-cancel': 'closeModal'
    'shown #addBudget': 'showModal'
    'changeDate': => @$('#starts_on').blur()

  initialize: ->
    super()
    @listenTo(@collection, 'add', @newBudgetAdded)
    $(document).on('keydown', 'j', @selectNext)
    $(document).on('keydown', 'k', @selectPrevious)
    $(document).on('keydown', 'return', @openSelected)
    $(document).on('keydown', 'o', @openSelected)

  close: ->
    super()
    $(document).off('keydown', null, @selectNext)
    $(document).off('keydown', null, @selectPrevious)
    $(document).off('keydown', null, @openSelected)

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
      @collection.add(newBudget)
    else
      @collection.add({starts_on: @$('#starts_on').val()})

    @closeModal()

  showModal: =>
    @$('#starts_on').val(@formatDate(new Date())).datepicker()

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
    view = @newView(BudgetApp.Views.IndexRowView, {collection: @collection, model : budget})
    @$('.row-fluid:last').before(view.render().el)

  addAll: ->
    @collection.each(@renderBudget)

  render: ->
    $(@el).html(@template())
    @addAll()
    $('.nav.budget-list').hide()
    @$('.budget:first').addClass('selected')
    @

