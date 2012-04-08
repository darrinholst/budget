Budget.delete_all

budget = Budget.create!(starts_on: Time.now.to_date)

budget.income_buckets.create!(name: "Salary", budgeted: 200000)

bills = budget.categories.create!(name: "Bills")
bills.buckets.create!(name: "Alliant Energy", budgeted: 17000)
bills.buckets.create!(name: "DirecTV", budgeted: 8500, spent: 8500)

food = budget.categories.create!(name: "Food")
food.buckets.create!(name: "Groceries", budgeted: 50000)
food.buckets.create!(name: "Buffalo Wild Wings", budgeted: 20000)
food.buckets.create!(name: "Dining Out", budgeted: 10000, spent: 1000)
