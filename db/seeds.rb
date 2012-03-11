Budget.delete_all

budget = Budget.create!(starts_on: Chronic.parse("8/5/2012").to_date)
bills = budget.categories.create!(name: "Bills")
bills.buckets.create!(name: "Alliant Energy")
bills.buckets.create!(name: "DirecTV")
