BudgetApp::Application.routes.draw do
  devise_for :users

  root to: 'landing#index'
  get "sandbox/*anything", to: "sandbox#index", as: :sandbox
  get "shared/:token", to: "shared#show"

  resources :budgets do
    resources :incomes, only: [:create, :update, :destroy]

    resources :categories, only: [:create, :update, :destroy] do
      resources :expenses, only: [:create, :update, :destroy]
    end
  end
end
