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
  resources :players, only: [] do
    post :damage_to_enemies, on: :collection
    post :heal, on: :collection
    post :damage_to, on: :collection
    post :kaboom, on: :collection
  end
  # Defines the root path route ("/")
  root "houses#index"
end
