Rails.application.routes.draw do
  namespace :api do
    resources :recipes
  end


  root to: 'home#show'
end
