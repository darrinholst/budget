BudgetApp::Application.routes.draw do
  devise_for :users

  root :to => 'budgets#index'

  resources :budgets do
    post "incomes", :to => 'budgets#create_income'
    put "incomes/:id", :to => 'budgets#update_income'
    delete "incomes/:id", :to => 'budgets#delete_income'

    post "categories", :to => 'budgets#create_category'
    put "categories/:id", :to => 'budgets#update_category'

    post "categories/:category_id/expenses", :to => 'budgets#create_expense'
    put "categories/:category_id/expenses/:id", :to => 'budgets#update_expense'
    delete "categories/:category_id/expenses/:id", :to => 'budgets#delete_expense'
  end
end
