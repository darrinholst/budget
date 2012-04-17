class BudgetApp.Views.BudgetsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets"]
  className: "budgets"

  events: ->
    "click .modal-footer .btn-success": "addBudget"
    "click .modal-footer .btn-cancel": "closeModal"
    "changeDate": => @$("#starts_on").blur()

  initialize: ->
    @collection.on "add", @newBudgetAdded

  addBudget: =>
    @collection.add({starts_on: @$("#starts_on").val()})
    @closeModal()

  closeModal: =>
    @$('#addBudget').modal('hide')

  newBudgetAdded: (budget) =>
    budget.save({},
      success: (budget) =>
        @closeModal()
        @render()

      error: =>
        @closeModal()
        alert("Couldn't save new budget")
    )

  renderBudget: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({collection: @collection, model : budget})
    @$(".row-fluid:last").before(view.render().el)

  addAll: =>
    @collection.each(@renderBudget)

  render: =>
    budgets = ({date: @formatDate(budget.startsOn())} for budget in @collection.models)

    $(@el).html(@template(
      budgets: budgets
      currentDate: @formatDate(new Date())
    ))

    @addAll()
    @$("#starts_on").datepicker()
    @

