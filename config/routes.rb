BudgetApp::Application.routes.draw do
  devise_for :users

  root to: 'landing#index'
  get "sandbox/*anything", to: "sandbox#index", as: :sandbox
  get "shared/:token", to: "shared#show"

  resources :budgets do
    collection do
      get :export
    end

    resources :incomes, only: [:create, :update, :destroy]

    resources :categories, only: [:create, :update, :destroy] do
      resources :expenses, only: [:create, :update, :destroy]
    end
  end

  scope "buckets/:bucket_id" do
    resources :itemizations, only: [:create, :update, :destroy]
  end
end
