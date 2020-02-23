Cmor::Legal::Engine.routes.draw do
  resources :privacy_policies do
    post :toggle_published, on: :member
  end
  resources :personal_data, :only => [:index, :show]
  root to: 'home#index'
end
