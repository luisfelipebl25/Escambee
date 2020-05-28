Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get '/how-it-works', to: 'pages#howitworks'
  get '/profile', to: 'pages#profile'
  get '/search', to: 'pages#search', as: :search
end
