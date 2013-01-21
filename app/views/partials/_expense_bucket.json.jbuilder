json.id expense_bucket.id
json.name expense_bucket.name
json.budgeted expense_bucket.budgeted
json.spent expense_bucket.spent
json.sort_order expense_bucket.sort_order

json.itemizations expense_bucket.itemizations do |json, itemization|
  json.partial! "partials/itemization.json.jbuilder", json: json, itemization: itemization
end
