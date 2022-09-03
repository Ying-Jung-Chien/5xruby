Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "login#new"
  resources :users
  resources :tasks
  resources :tags

  get 'login', to: 'login#new'
  post 'login', to: 'login#create'
  get 'logout', to: 'login#destroy'
end
