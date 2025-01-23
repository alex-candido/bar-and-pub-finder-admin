# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :places
    resources :dashboard, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :places, only: [:index]
    end
  end

  # Defines the root path route ("/")
  root "admin/dashboard#index"
end
