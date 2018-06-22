Rails.application.routes.draw do
  get 'calculator/index'
  get '/index', to: 'calculator#compute'

  root 'calculator#index'
end
