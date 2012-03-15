BudgetApp::Application.routes.draw do
  root :to => 'budgets#index'
  resources :budgets
end
