Cmor::Blog::Api::Engine.routes.draw do
  resources :posts do
    get :count, on: :collection
  end
  resources :asset_details do
    get :count, on: :collection
  end
end
