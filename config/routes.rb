BudgetApp::Application.routes.draw do
  root to: 'backbone#index'
  get 'budgets', to: 'backbone#index'
  get 'budgets/*a', to: 'backbone#index'
end
