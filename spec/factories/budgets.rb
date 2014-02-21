FactoryGirl.define do
  factory :budget do
    starts_on Time.now
    ends_on Time.now + 1.day
    actual_balance 10000

    income_buckets {[
      FactoryGirl.build(:income_bucket)
    ]}

    categories {[
      FactoryGirl.build(:category)
    ]}
  end
end

