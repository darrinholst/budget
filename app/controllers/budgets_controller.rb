class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    find_budgets
    render :index
  end

  def show
    index
  end

  def create
    budget = current_user.budgets.create(budget_params)
    render :json => budget
  end

  def update
    budget = current_user.budgets.find(params[:id])
    budget.update_attributes(budget_params)
    render :json => budget
  end

  def destroy
    budget = current_user.budgets.find(params[:id])
    budget.destroy
    render :json => budget
  end

  def create_income
    income = find_budget.income_buckets.create(income_params)
    render :json => income
  end

  def update_income
    bucket = find_budget.income_buckets.find(params[:id])
    bucket.update_attributes(income_params)
    render :json => bucket
  end

  def delete_income
    bucket = find_budget.income_buckets.find(params[:id])
    bucket.destroy
    render :json => bucket
  end

  def create_category
    category = find_budget.categories.create(category_params)
    render :json => category
  end

  def update_category
    category = find_budget.categories.find(params[:id])
    category.update_attributes(category_params)
    render :json => category
  end

  def create_expense
    category = find_budget.categories.find(params[:category_id])
    p category
    bucket = category.buckets.create(expense_params)
    render :json => bucket
  end

  def update_expense
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.update_attributes!(expense_params)
    render :json => bucket
  end

  def delete_expense
    bucket = find_budget.expense_buckets.find(params[:id])
    bucket.destroy
    render :json => bucket
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def find_budgets
    @budgets = current_user.budgets.order("starts_on desc").includes([:income_buckets, {:categories => :buckets}]).all
  end

  def budget_params
    params.slice(:starts_on, :actual_balance)
  end

  def income_params
    params.slice(:name, :budgeted)
  end

  def category_params
    params.slice(:name)
  end

  def expense_params
    params.slice(:name, :budgeted, :spent)
  end
end
