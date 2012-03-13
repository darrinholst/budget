Budget.delete_all

budget = Budget.create!(starts_on: Chronic.parse("8/5/2012").to_date)

budget.income_buckets.create!(name: "Salary", budgeted: "$2000")

bills = budget.categories.create!(name: "Bills")
bills.buckets.create!(name: "Alliant Energy", budgeted: "$170.00")
bills.buckets.create!(name: "DirecTV", budgeted: "$85", spent: "$85")

food = budget.categories.create!(name: "Food")
food.buckets.create!(name: "Groceries", budgeted: "$500.00")
food.buckets.create!(name: "Buffalo Wild Wings", budgeted: "$200.00")
food.buckets.create!(name: "Dining Out", budgeted: "$100", spent: "$10")
