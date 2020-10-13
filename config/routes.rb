Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :raffles, :path_names => {:edit => 'enter' }
  resources :tickets, :path_names => {:edit => 'claim' }

  resources :raffles do
    resources :users, only: [:index]
  end

  resources :user do
    resources :tickets, only: [:new]
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  root 'welcome#home'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'


end
