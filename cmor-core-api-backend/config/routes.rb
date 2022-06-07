Cmor::Core::Api::Backend::Engine.routes.draw do
  resources :api_tokens
  
  root to: 'home#index'
end
