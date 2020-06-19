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
    post :toggle_published, on: :member
    post :reposition, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    get :export, on: :collection
    post :dump, on: :collection
  end
  
  resources :layouts do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
  end

  resources :pages do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    get :export, on: :collection
    post :dump, on: :collection
  end
  
  resources :partials do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
  end
  
  resources :templates do
    post :toggle_published, on: :member
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
  end

  root to: 'home#index'
end
