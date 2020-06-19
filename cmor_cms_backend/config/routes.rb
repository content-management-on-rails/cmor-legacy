Cmor::Cms::Backend::Engine.routes.draw do
  resources :add_homepages_service, only: [:create, :new]
  resources :import_partials_service, only: [:create, :new]

  resources :content_boxes do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end

  resources :navigations do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end
  
  resources :navigation_items do
    post :toggle_published, on: :member
    post :reposition, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end
  
  resources :layouts do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end

  resources :pages do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end
  
  resources :partials do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end
  
  resources :templates do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    export_resources
  end

  root to: 'home#index'
end
