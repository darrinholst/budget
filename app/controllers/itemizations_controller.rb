class ItemizationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @itemization = find_bucket.itemizations.create!(itemization_params)
  end

  def update
    @itemization = find_bucket.itemizations.find(params[:id])
    @itemization.update_attributes!(itemization_params)
  end

  def destroy
    @itemization = find_bucket.itemizations.find(params[:id])
    @itemization.destroy
  end

  private

  def find_bucket
    current_user.buckets.find(params[:bucket_id])
  end

  def itemization_params
    params.permit(
      :name,
      :spent
    )
  end
end
