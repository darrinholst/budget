class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    category = find_budget.categories.create!(category_params)
    render :json => category
  end

  def update
    category = find_budget.categories.find(params[:id])
    category.update_attributes!(category_params)
    render :json => category
  end

  def destroy
    category = find_budget.categories.find(params[:id])
    category.destroy
    render :json => category
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def category_params
    params.slice(:name, :buckets_attributes)
  end
end
