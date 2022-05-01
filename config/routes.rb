# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :categories, except: %i[new edit destroy]
      resources :accounts_payables, except: %i[new edit]
      resources :accounts_receivables, except: %i[new edit]
    end
  end
end
