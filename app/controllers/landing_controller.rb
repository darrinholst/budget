class LandingController < ApplicationController
  def index
    @budgets = Budget.all(:include => [
      :income_buckets,
      :categories => [:buckets]
    ])
  end
end
