class IncomeBucketRepository
  def destroy(user, budget_id, bucket_id)
    bucket = user.budgets.find(budget_id).income_buckets.find(bucket_id)
    bucket.destroy
    bucket
  end
end
