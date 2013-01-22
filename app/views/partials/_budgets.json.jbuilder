json.array!(budgets) do |json, budget|
  json.partial! "partials/budget", :formats => [:json], json: json, budget: budget
end
