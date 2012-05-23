require 'income_bucket_repository'

class IncomesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def initialize(incomeBucketRepository = IncomeBucketRepository.new)
    @incomeBucketRepository = incomeBucketRepository
  end

  def create
    income = find_budget.income_buckets.create!(income_params)
    render :json => income
  end

  def update
    bucket = find_budget.income_buckets.find(params[:id])
    bucket.update_attributes!(income_params)
    render :json => bucket
  end

  def destroy
    destroyed = @incomeBucketRepository.destroy(current_user, params[:budget_id], params[:id])
    render json: destroyed
  end

  private

  def find_budget
    current_user.budgets.find(params[:budget_id])
  end

  def income_params
    params.slice(:name, :budgeted)
  end
end
