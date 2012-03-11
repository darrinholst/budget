class BudgetsController < ApplicationController
  def index
    @budgets = BudgetDecorator.all
  end

  def new
    @budget = BudgetDecorator.new
  end

  def create
    @budget = BudgetDecorator.new(budget_params)

    if(@budget.save)
      redirect_to budgets_path
    else
      render :new
    end
  end

  def show
    @budget = BudgetDecorator.find(params[:id])
    render :edit
  end

  def update
    @budget = BudgetDecorator.find(params[:id])

    if(@budget.update_attributes(budget_params))
      redirect_to budgets_path
    else
      render :show
    end
  end

  def destroy
    BudgetDecorator.find(params[:id]).destroy
    redirect_to budgets_path
  end

  private

  def budget_params
    params[:budget].slice(:starts_on)
  end
end
