class SharedController < ApplicationController
  def show
    @budgets = [Budget.find_by_token(params[:token])]
    render 'budgets/index'
  end
end
