Cmor::MultiTenancy::Engine.routes.draw do
  resources :clients do
    post :reposition, on: :member
  end

  root to: 'home#index'
end
