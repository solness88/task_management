Rails.application.routes.draw do
  get 'sessions/new'
  get '/', to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :labellings, only: [:create, :destroy]
  namespace :admin do
    resources :users
  end
end
