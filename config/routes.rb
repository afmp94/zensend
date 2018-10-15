Rails.application.routes.draw do
  root 'root#index'
  get 'root/index'

  get 'otp/enable'
  get 'otp/validate'
  get 'otp/disable'
  get 'otp/status'
  resources :profiles
  resources :codes

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
