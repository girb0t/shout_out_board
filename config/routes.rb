Rails.application.routes.draw do
  root 'home#show'

  # boards
  get  '/boards/new',             to: 'boards#new'
  # get  '/boards/:key',            to: 'boards#show'
  # post '/boards',                 to: 'boards#create'
  get  '/boards/validate_key',    to: 'boards#validate_key'
end
