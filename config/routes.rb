Rails.application.routes.draw do
  resources :recipies, only: :index
end
