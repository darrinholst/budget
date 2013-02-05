class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @expense_bucket = find_budget.categories.find(params[:category_id]).buckets.create!(expense_params)
  end

  def update
    @expense_bucket = find_budget.expense_buckets.find(params[:id])
    @expense_bucket.update_attributes!(expense_params)
  end

  def destroy
    @expense_bucket = find_budget.expense_buckets.find(params[:id])
    @expense_bucket.destroy
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
