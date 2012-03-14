class BudgetsController < ApplicationController
  respond_to :json

  def index
    @budgets = Budget.all(:include => [
      :income_buckets,
      :categories => [:buckets]
    ])

    render :json => @budgets.to_json(
      :only => [:id, :starts_on],

      :include => {
        :income_buckets => {:only => [:id, :name, :budgeted]},
        :categories => {
          :only => [:id, :name],
          :include => {:buckets => {:only => [:id, :name, :budgeted, :spent]}}
        }
      }
    )
  end
end
