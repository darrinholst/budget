json.id category.id
json.name category.name
json.sort_order category.sort_order

json.buckets category.buckets do |json, bucket|
  json.partial! "partials/expense_bucket.json.jbuilder", json: json, expense_bucket: bucket
end
