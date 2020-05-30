# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users

  post 'add_to_wishlist', to: 'users#add_to_wishlist'
  delete 'remove_from_wishlist', to: 'users#remove_from_wishlist'

  post 'add_to_ownlist', to: 'users#add_to_ownlist'
  delete 'remove_from_ownlist', to: 'users#remove_from_ownlist'

  post 'answer_proposal', to: 'users#answer_proposal'
  post 'answer_match', to: 'users#answer_match'

  get '/profile', to: 'pages#profile'
  get '/collection', to: 'pages#collection'
  get '/search', to: 'pages#search', as: :search
end
