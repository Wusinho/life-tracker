Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :games, only: [:show, :create, :update]
  resources :profiles
  resources :houses
  # Defines the root path route ("/")
  root "houses#index"
end
