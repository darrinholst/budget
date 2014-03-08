Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root to: 'backbone#index'
  get 'budgets', to: 'backbone#index'
  get 'budgets/*a', to: 'backbone#index'
end
