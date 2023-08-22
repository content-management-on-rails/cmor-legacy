Cmor::Links::Engine.routes.draw do
  resources :categories
  resources :links do
    post :reposition, on: :member
  end

  root to: 'home#index'
end
