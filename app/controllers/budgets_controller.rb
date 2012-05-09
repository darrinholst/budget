class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    @budgets = current_user.budgets.order("starts_on desc").includes([:income_buckets, {:categories => :buckets}]).all
    render :index
  end

  def show
    index
  end

  def create
    budget = current_user.budgets.create!(budget_params)
    render :json => budget
  end

  def update
    budget = current_user.budgets.find(params[:id])
    budget.update_attributes!(budget_params)
    render :json => budget
  end

  def destroy
    budget = current_user.budgets.find(params[:id])
    budget.destroy
    render :json => budget
  end

  private

  def budget_params
    params.slice(:starts_on, :actual_balance, :income_buckets_attributes, :categories_attributes)
  end
end
