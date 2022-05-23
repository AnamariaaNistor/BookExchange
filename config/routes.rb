# frozen_string_literal: true

Rails.application.routes.draw do
  resources :donations
  resources :requests
  get 'dashboard/index'
  devise_for :users
  resources :exchanges
  resources :books
  resources :dashboard
  resources :users, only: [:show]
  devise_scope :user do
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get 'books_owned', to: 'books#owned'
  get 'users_books/:id', to: 'books#users_books'
end
