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
    @budget = budget_repository.create(current_user, budget_params)
  end

  def update
    @budget = budget_repository.update(current_user, params[:id], budget_params)
  end

  def destroy
    @budget = budget_repository.delete(current_user, params[:id])
  end

  private

  def budget_params
    params.permit(
      :starts_on,
      :actual_balance,
      :income_buckets_attributes,
      :categories_attributes
    )
  end

  def budget_repository
    @budget_repository ||= BudgetRepository.new
  end
end

