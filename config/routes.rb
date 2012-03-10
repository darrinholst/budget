BudgetApp::Application.routes.draw do
  root :to => 'landing#index'

  resources :budgets
end
