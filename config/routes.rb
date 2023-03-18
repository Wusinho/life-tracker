Rails.application.routes.draw do
  devise_for :users,
             path: '',
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :games
  resources :profiles
  resources :houses
  # Defines the root path route ("/")
  root "houses#index"
end
