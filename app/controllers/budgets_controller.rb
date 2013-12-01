class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  attr_writer :budget_repository

  def index
    authorize Budget
    @budgets = budget_repository.all_for(current_user)
    render :index
  end

  def show
    authorize Budget
    index
  end

  def create
    authorize Budget
    budget = budget_repository.create(budget_params.merge(:user_id => current_user.id))
    render json: budget
  end

  def update
    budget = budget_repository.find(params[:id])
    authorize budget
    budget_repository.update(budget, budget_params)
    render json: budget
  end

  def destroy
    budget = budget_repository.find(params[:id])
    authorize budget
    budget_repository.delete(budget)
    render json: budget
  end

  private

  def budget_params
    params.permit(:starts_on, :actual_balance).tap do |whitelisted|
      whitelisted[:income_buckets_attributes] = params[:income_buckets_attributes] || []
      whitelisted[:categories_attributes] = params[:categories_attributes] || []
    end
  end

  def budget_repository
    @budget_repository ||= BudgetRepository.new
  end
end

