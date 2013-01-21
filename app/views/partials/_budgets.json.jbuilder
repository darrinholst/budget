json.array!(budgets) do |json, budget|
  json.partial! "partials/budget.json.jbuilder", json: json, budget: budget
end
