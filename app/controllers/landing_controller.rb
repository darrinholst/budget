class LandingController < ApplicationController
  def index
    if user_signed_in?
      redirect_to budgets_url
    end
  end
end
