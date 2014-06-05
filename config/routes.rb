BarSpinner::Application.routes.draw do

  get "script/:id" => 'scripts#script'
  get "preview" => 'scripts#preview', as: :script_preview
  get "link/:id" => 'scripts#link'

  resources :ad_platforms do 
    resources :bars
  end


  get "home/index"

  devise_for :users

  root to: "home#index"
end
