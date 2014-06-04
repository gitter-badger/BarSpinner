BarSpinner::Application.routes.draw do

  resources :ad_platforms


  resources :bars

  get "home/index"

  devise_for :users

  root to: "home#index"
end
