require 'spec_helper'
require 'landing_controller'

describe LandingController do
  let(:controller) {LandingController.new}

  describe "#index" do
    it "redirects to budgets page when signed in" do
      controller.should_receive(:user_signed_in?).and_return(true)
      controller.should_receive(:budgets_url).and_return("budgets url")
      controller.should_receive(:redirect_to).with("budgets url")
      controller.index
    end

    it "renders landing page when not signed in" do
      controller.should_receive(:user_signed_in?).and_return(false)
      controller.index
    end
  end
end

