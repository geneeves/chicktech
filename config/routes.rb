Chicktech::Application.routes.draw do
  resources :events
  devise_for :users
  resources :users 
  resources :jobs
  resources :tasks
  root :to => "static_pages#index"
end
