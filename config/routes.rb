Rails.application.routes.draw do
  
  root :to => "home#index"
  devise_for :users
  resources :users do
  	member do      
      post 'subscribe'
      post 'unsubscribe'
    end
  end
  get 'status_monitor' => 'users#status_monitor'
end
