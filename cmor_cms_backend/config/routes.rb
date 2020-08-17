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
    acts_as_published
    acts_as_list
  end
  
  resources :layouts do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    acts_as_published
  end

  resources :pages do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    acts_as_published
  end
  
  resources :partials do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    acts_as_published
  end

  resources :redirects do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    acts_as_published
    acts_as_list
    post :destroy_many, on: :collection
  end
  
  resources :templates do
    Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    acts_as_published
  end

  root to: 'home#index'
end
