Rails.application.routes.draw do
  root 'static_pages#home'
  # root 'players#index'
  get '/addPlayer', to: 'players#new'
  resources :players
end
