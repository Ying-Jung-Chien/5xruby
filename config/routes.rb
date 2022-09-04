Rails.application.routes.draw do
  namespace :admin do
      resources :tags
      resources :users

      root to: "users#index"
      get 'user/:id/tasks', to: 'users#tasks', as: 'user_tasks'
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
