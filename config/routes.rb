Rails.application.routes.draw do
  config = Rails.application.config.baukis

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [:create, :destroy]
      resource :account, except: [:new, :create, :destroy]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      post 'session' => 'sessions#create', as: :session
      delete 'session' => 'sessions#destroy'
      resources :staff_members
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  # update of default root path (/)
  root 'errors#routing_error'

  # setting of anyother url (*anything)
  get '*anything' => 'errors#routing_error'
end
