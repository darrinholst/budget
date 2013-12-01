class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def create
    render json: find_budget.categories.find(params[:category_id]).buckets.create!(expense_params)
  end

  def update
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.update_attributes!(expense_params)
    render json: bucket
  end

  def destroy
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.destroy
    render json: bucket
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def expense_params
    params.permit(
      :name,
      :budgeted,
      :spent,
      :sort_order,
    )
  end
end
