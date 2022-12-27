Cmor::Blog::Engine.routes.draw do
  resources :posts do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
    post :reposition, on: :member
  end
  resources :asset_details do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :reposition, on: :member
  end

  root to: "home#index"
end
