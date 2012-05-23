require 'spec_helper'
require 'incomes_controller'

describe IncomesController do
  let(:income_bucket_repository) {stub}
  let(:controller) {IncomesController.new(income_bucket_repository)}

  describe "#destroy" do
    let(:bucket) {stub}

    it "deletes the bucket" do
      controller.params = {budget_id: :budget_id, id: :bucket_id}
      controller.current_user = :current_user
      income_bucket_repository.should_receive(:destroy).with(:current_user, :budget_id, :bucket_id).and_return(bucket)

      controller.destroy
    end

    it "renders the destroyed bucket as json" do
      income_bucket_repository.should_receive(:destroy).and_return(bucket)
      controller.should_receive(:render).with(json: bucket)

      controller.destroy
    end
  end
end
