class BudgetsController < ApplicationController
  respond_to :json

  def index
    find_budgets
  end

  def show
    find_budgets
    render :index
  end

  private

  def find_budgets
    @budgets = Budget.all(:include => [
      :income_buckets,
      :categories => [:buckets]
    ])
  end
end
