Rails.application.routes.draw do
  resources :raffles
  resources :tickets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  root 'welcome#home'
end
