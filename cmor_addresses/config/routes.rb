Cmor::Addresses::Engine.routes.draw do
  resources :addresses 
  resources :roles 
    
  root to: 'home#index'
end
