require 'spec_helper'
require 'incomes_controller'

describe IncomesController do
  let(:income_bucket_repository) {double}
  let(:controller) {
    controller = IncomesController.new
    controller.income_bucket_repository = income_bucket_repository
    controller
  }

  describe "#destroy" do
    let(:bucket) {double}

    it "deletes the bucket" do
      controller.params = {budget_id: :budget_id, id: :bucket_id}
      controller.current_user = :current_user
      income_bucket_repository.should_receive(:destroy).with(:current_user, :budget_id, :bucket_id).and_return(bucket)

      controller.destroy

      controller.render_args.should == {json: bucket}
    end
  end
end
