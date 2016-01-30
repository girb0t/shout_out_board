Rails.application.routes.draw do
  root 'posts#new'

  # TO DO: Create a proper admin controller.
  get '/admin',                    to: 'home#show'

  # boards
  get  '/boards',                 to: 'boards#index'
  get  '/boards/new',             to: 'boards#new'
  post '/boards',                 to: 'boards#create'
  put  '/boards/:key',            to: 'boards#update', as: 'boards_update'
  get  '/boards/validate_key',    to: 'boards#validate_key'
  get  '/boards/:key',            to: 'boards#show'

  # posts
  get  '/posts/new',              to: 'posts#new'
  get  '/posts/validate_key',     to: 'posts#validate_key'
  post '/posts',                  to: 'posts#create'

  # users
  # get  '/signup',                 to: 'users#new'
  # post '/users',                  to: 'users#create'

  # sessions
  # get '/logout',                  to: 'sessions#destroy'
  # get '/login',                   to: 'sessions#new'
  # post '/login',                  to: 'sessions#create'
end
