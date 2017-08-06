Rails.application.routes.draw do
  resources :moments
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
