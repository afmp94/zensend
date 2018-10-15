Rails.application.routes.draw do

  resources :profiles
  resources :codes
  devise_for :users
  root to: 'root#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
