require 'spec_helper'
require 'incomes_controller'

describe IncomesController do
  let(:income_bucket_repository) {stub}
  let(:controller) {
    controller = IncomesController.new
    controller.income_bucket_repository = income_bucket_repository
    controller
  }

  describe "#destroy" do
    let(:bucket) {stub}

    it "deletes the bucket" do
      controller.params = {budget_id: :budget_id, id: :bucket_id}
      controller.current_user = :current_user
      income_bucket_repository.should_receive(:destroy).with(:current_user, :budget_id, :bucket_id).and_return(bucket)

      controller.destroy

      controller.instance_variable_get("@income_bucket").should == bucket
    end
  end
end
