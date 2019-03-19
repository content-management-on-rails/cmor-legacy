Cmor::Links::Backend::Engine.routes.draw do
  # backend_resources :categories
  # backend_resources :links
  resources :categories
  resources :links

  root to: 'home#index'
end
