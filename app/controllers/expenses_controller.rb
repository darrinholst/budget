class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    category = find_budget.categories.find(params[:category_id])
    bucket = category.buckets.create!(expense_params)
    render :json => bucket
  end

  def update
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.update_attributes!(expense_params)
    render :json => bucket
  end

  def destroy
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.destroy
    render :json => bucket
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def expense_params
    params.slice(:name, :budgeted, :spent, :itemizations_attributes)
  end
end
