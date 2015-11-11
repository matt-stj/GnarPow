Rails.application.routes.draw do
  get "/", to: "items#index"
  resources :items, only: [:index]
  resources :categories, only: [:show, :index], param: :slug
  resources :users, only: [:new, :create, :show]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
