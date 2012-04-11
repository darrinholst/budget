BudgetApp::Application.routes.draw do
  devise_for :users

  root :to => 'budgets#index'

  resources :budgets do
    post "incomes", :to => 'budgets#create_income'
    put "incomes/:id", :to => 'budgets#update_income'
    put "category/:id", :to => 'budgets#update_category'
    put "expense/:id", :to => 'budgets#update_expense'
  end
end
