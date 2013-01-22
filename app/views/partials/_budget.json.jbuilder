json.id budget.id
json.starts_on budget.starts_on
json.actual_balance budget.actual_balance

shallow ||= false

unless shallow
  json.income_buckets budget.income_buckets do |json, income_bucket|
    json.partial! "partials/income_bucket", :formats => [:json], json: json, income_bucket: income_bucket
  end

  json.categories budget.categories do |json, category|
    json.partial! "partials/category", :formats => [:json], json: json, category: category
  end
end

