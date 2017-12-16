Rails.application.routes.draw do
  resources :calendars
  root to: 'visitors#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  get '/about', to: 'visitors#about'
end
