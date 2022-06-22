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

  patch 'accept_request/:id', to: 'requests#accept_request', as: 'accept_request'
  patch 'decline_request/:id', to: 'requests#decline_request', as: 'decline_request'
  patch 'exchange/mark_as_done/:id', to: 'exchanges#mark_as_done', as: 'exchange_mark_as_done'
  patch 'donation/mark_in_progress/:id', to: 'donations#mark_in_progress', as: 'donation_mark_in_progress'
  patch 'donation/mark_as_done/:id', to: 'donations#mark_as_done', as: 'donation_mark_as_done'
end
