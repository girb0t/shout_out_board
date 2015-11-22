Rails.application.routes.draw do
  root 'home#show'

  # boards
  get  '/boards/new',             to: 'boards#new'
  post '/boards',                 to: 'boards#create'
  get  '/boards/validate_key',    to: 'boards#validate_key'
  get  '/boards/:key',            to: 'boards#show'
end
