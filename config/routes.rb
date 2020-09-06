Rails.application.routes.draw do
  root "scrps#index"
  get "scrps/index"
  resources :scrps
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
