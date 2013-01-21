FactoryGirl.define do
  factory :budget do
    id 1
    starts_on Time.now
    actual_balance 10000

    income_buckets {[
      FactoryGirl.build(:income_bucket)
    ]}

    categories {[
      FactoryGirl.build(:category)
    ]}
  end
end

