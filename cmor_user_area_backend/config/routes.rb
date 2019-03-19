Cmor::UserArea::Backend::Engine.routes.draw do
  resources :create_default_user_service, only: [:new, :create]
  
  # backend_resources :users do
  resources :users do
    get :autocomplete, on: :collection
  end

  resource :current_user, only: [:show]
  resource :user_sidebar, only: [:show]
  
  root to: 'home#index'
end
