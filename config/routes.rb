Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  get '/about', to: 'visitors#about'
  get 'getcalendar', to: 'users#getcalendar'
  get 'calendar', to: 'users#calendar'
end
