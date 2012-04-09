class BudgetsController < ApplicationController
  respond_to :json

  def index
    find_budgets
  end

  def show
    find_budgets
    render :index
  end

  def update
    budget = Budget.find(params[:id])
    budget.update_attributes(params[:budget])
    head :ok
  end

  def update_income
    bucket = find_budget.income_buckets.find(params[:id])
    bucket.update_attributes(params.slice(:name, :budgeted))
    head :ok
  end

  def update_category
    category = find_budget.categories.find(params[:id])
    category.update_attributes(params.slice(:name))
    head :ok
  end

  def update_expense
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.update_attributes(params.slice(:name, :budgeted, :spent))
    head :ok
  end

  private

  def find_budget
    Budget.find(params[:budget_id])
  end

  def find_budgets
    @budgets = Budget.all(:include => [
      :income_buckets,
      :categories => [:buckets]
    ])
  end
end
