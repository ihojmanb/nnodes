Rails.application.routes.draw do
  root 'rounds#index'
  # root 'players#index'
  get '/addPlayer', to: 'players#new'
  resources :players
  resources :rounds
end
