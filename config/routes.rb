Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #resources :howitworks
  get "/howitworks", to: "howitworks#index"

  devise_for :users
  root 'home#index'

end
