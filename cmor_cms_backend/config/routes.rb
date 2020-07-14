Cmor::Cms::Backend::Engine.routes.draw do
  resources :add_homepages_service, only: [:create, :new]
  resources :import_partials_service, only: [:create, :new]

  resources :content_boxes do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
  end

  resources :navigations do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
  end
  
  resources :navigation_items do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
    post :reposition, on: :member
  end
  
  resources :layouts do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
  end

  resources :pages do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
  end
  
  resources :partials do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
  end
  
  resources :templates do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    post :toggle_published, on: :member
  end

  root to: 'home#index'
end
