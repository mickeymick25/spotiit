Rails.application.routes.draw do

  resources :classifiedads
  resources :propertyads
  resources :propertyadmgts
  resources :propertybuyads
  resources :issuerdashboard
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #resources :howitworks
  get "/howitworks", to: "howitworks#index"

  devise_for :users
  root 'home#index'

end
