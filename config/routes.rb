Rails.application.routes.draw do
  resources :posts

  # User Authentication routes.
  resources :users, only: %i[create]
  get '/signup', to: 'users#new'
  get '/users/:uid', to: 'users#show', as: 'user'
  get '/users/edit/:uid', to: 'users#edit', as: 'edit_user'
  patch '/users/edit/:uid', to: 'users#update', as: 'update_user'
  delete '/users/destroy/:uid', to: 'users#destroy', as: 'destroy_user'
  get '/email/confirmation/:uid', to: 'users#confirm_account', as: 'confirm_user_account'

  # SESSIONS pages
  get '/confirmation', to: 'sessions#confirmation'
  patch '/confirmation/send', to: 'sessions#confirmation_send'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'
  get '/instructions', to: 'sessions#instructions'
  post '/instructions/send', to: 'sessions#instructions_send'
  get '/recover/:token', to: 'sessions#recover'
  patch '/recover/password/:token', to: 'sessions#recover_password', as: :recover_password

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"
end
