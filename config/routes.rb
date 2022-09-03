Rails.application.routes.draw do
  namespace :admin do
      resources :tags
      resources :tasks
      resources :users

      root to: "login#new"
  end

  # Defines the root path route ("/")
  root "login#new"
  resources :users
  resources :tasks
  resources :tags

  get 'login', to: 'login#new'
  post 'login', to: 'login#create'
  get 'logout', to: 'login#destroy'
end
