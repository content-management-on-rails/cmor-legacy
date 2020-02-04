Cmor::Legal::Engine.routes.draw do
  resources :privacy_policies
  resources :personal_data, :only => [:index, :show]
  root to: 'home#index'
end
