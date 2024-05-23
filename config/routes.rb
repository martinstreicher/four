# frozen_string_literal: true

Rails.application.routes.draw do
  resources :moves, only: %i[edit]
  resources :games, only: %i[new index]

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'games#index'
end
