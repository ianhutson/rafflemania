Rails.application.routes.draw do
  resources :raffles, :path_names => {:edit => 'claim' }
  resources :tickets, :path_names => {:edit => 'get' }
  resources :users

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  root 'welcome#home'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
end
