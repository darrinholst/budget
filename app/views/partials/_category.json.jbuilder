json.id category.id
json.name category.name
json.sort_order category.sort_order

shallow ||= false

unless shallow
  json.buckets category.buckets do |json, bucket|
    json.partial! "partials/expense_bucket", :formats => [:json], json: json, expense_bucket: bucket
  end
end
