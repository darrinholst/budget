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
    render :json => budget
  end

  def create_income
    income = find_budget.income_buckets.create(params.slice(:name, :budgeted))
    render :json => income
  end

  def update_income
    bucket = find_budget.income_buckets.find(params[:id])
    bucket.update_attributes(params.slice(:name, :budgeted))
    render :json => bucket
  end

  def update_category
    category = find_budget.categories.find(params[:id])
    category.update_attributes(params.slice(:name))
    render :json => category
  end

  def update_expense
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.update_attributes(params.slice(:name, :budgeted, :spent))
    render :json => bucket
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
