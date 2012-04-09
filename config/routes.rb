BudgetApp::Application.routes.draw do
  root :to => 'budgets#index'

  resources :budgets do
    put "income/:id", :to => 'budgets#update_income'
    put "category/:id", :to => 'budgets#update_category'
    put "expense/:id", :to => 'budgets#update_expense'
  end
end
