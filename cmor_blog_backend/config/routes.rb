Cmor::Blog::Backend::Engine.routes.draw do
  resources :posts do
    post :toggle_published, on: :member
    post :reposition, on: :member
  end
  resources :asset_details do
    post :reposition, on: :member
  end

  root to: 'home#index'
end