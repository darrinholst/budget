class LandingController < ApplicationController
  def index
    redirect_to budgets_path
  end
end
