Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:show] do 
    resources :favorite_clips, only: [:show, :edit, :destroy, :update]
  end
  resources :users, only: [:new, :create]
  patch 'games/:id', to: 'games#favorite'
  resources :games, only: [:show]
  patch 'clips/:id', to: 'favorite_clips#favorite'
  resources :clips, only: [:show]
  resources :streamers, only: [:show]
  post '/twitch', to: 'pages#update_db'
  root 'pages#home'
end
