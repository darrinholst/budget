require 'spec_helper'
require 'budgets_controller'

describe BudgetsController do
  let(:budget_repository) {stub("Budget Repository")}
  let(:current_user) {stub("Current User")}
  let(:controller) {
    controller = BudgetsController.new
    controller.budget_repository = budget_repository
    controller.current_user = current_user
    controller
  }

  describe "#index" do
    it "should read all the budgets" do
      budget_repository.should_receive(:all_for).with(current_user).and_return("budgets")

      controller.index

      controller.render_args.should == :index
      controller.instance_variable_get("@budgets").should == "budgets"
    end
  end

  describe "#show" do
    it "should read all the budgets" do
      budget_repository.should_receive(:all_for).with(current_user).and_return("budgets")

      controller.show

      controller.render_args.should == :index
      controller.instance_variable_get("@budgets").should == "budgets"
    end
  end
end
