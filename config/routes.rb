Rails.application.routes.draw do
  
  root :to => "home#index"
  devise_for :users
  resources :users do
  end
  get 'status' => 'status#index'
end
