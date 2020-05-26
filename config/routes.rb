Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get '/how-it-works', to: 'pages#howitworks'
  get '/profile', to: 'pages#profile'
end
