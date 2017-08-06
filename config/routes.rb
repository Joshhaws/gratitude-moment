Rails.application.routes.draw do
  resources :moments
  root to: 'visitors#index'
  devise_for :users
  resources :users
  post 'twilio/process_sms' => 'moments#process_sms'
end
