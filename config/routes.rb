Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create, :show]
  patch 'games/:id', to: 'games#favorite'
  resources :games, only: [:index, :show]
  root 'pages#home'
end
