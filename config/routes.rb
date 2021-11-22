Rails.application.routes.draw do
  root 'static_pages#home'
  get '/addPlayer', to: 'players#new'
end
