class BudgetsController < ApplicationController
  before_filter :authenticate_user!

  attr_writer :budget_repository

  def index
    @budgets = budget_repository.all_for(current_user)
    render :index
  end

  def show
    index
  end

  def create
    @budget = current_user.budgets.create!(budget_params)
  end

  def update
    @budget = current_user.budgets.find(params[:id])
    @budget.update_attributes!(budget_params)
  end

  def destroy
    @budget = current_user.budgets.find(params[:id])
    @budget.destroy
  end

  private

  def budget_params
    params.slice(:starts_on, :actual_balance, :income_buckets_attributes, :categories_attributes)
  end

  def budget_repository
    @budget_repository ||= BudgetRepository.new
  end
end

