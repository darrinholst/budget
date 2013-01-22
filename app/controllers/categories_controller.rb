class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @category = find_budget.categories.create!(category_params)
  end

  def update
    @category = find_budget.categories.find(params[:id])
    @category.update_attributes!(category_params)
  end

  def destroy
    @category = find_budget.categories.find(params[:id])
    @category.destroy
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def category_params
    params.permit(
      :name,
      :buckets_attributes
    )
  end
end
