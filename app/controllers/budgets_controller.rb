class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)

    if(@budget.save)
      redirect_to budgets_path
    else
      render :new
    end
  end

  def show
    @budget = Budget.find(params[:id])
    render :edit
  end

  def update
    @budget = Budget.find(params[:id])

    if(@budget.update_attributes(budget_params))
      redirect_to budgets_path
    else
      render :show
    end
  end

  def destroy
    Budget.find(params[:id]).destroy
    redirect_to budgets_path
  end

  private

  def budget_params
    params[:budget].slice(:starts_on)
  end
end
