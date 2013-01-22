class IncomesController < ApplicationController
  before_filter :authenticate_user!

  attr_writer :income_bucket_repository

  def create
    @income_bucket = find_budget.income_buckets.create!(income_params)
  end

  def update
    @income_bucket = find_budget.income_buckets.find(params[:id])
    @income_bucket.update_attributes!(income_params)
  end

  def destroy
    @income_bucket = income_bucket_repository.destroy(current_user, params[:budget_id], params[:id])
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def income_params
    params.permit(
      :name,
      :budgeted
    )
  end

  def income_bucket_repository
    @income_bucket_repository ||= IncomeBucketRepository.new
  end
end
