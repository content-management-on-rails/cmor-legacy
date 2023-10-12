Cmor::Core::Settings::Engine.routes.draw do
  resources :settables
      
  root to: 'home#index'
end
