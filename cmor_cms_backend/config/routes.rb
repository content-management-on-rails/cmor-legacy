Cmor::Cms::Backend::Engine.routes.draw do
  resources :add_homepages_service, only: [:create, :new]
  resources :import_partials_service, only: [:create, :new]

  resources :content_boxes
  resources :navigations
  
  resources :navigation_items do
    post :toggle_published, on: :member
    post :reposition, on: :member
  end
  
  resources :pages do
    post :toggle_published, on: :member
  end
  
  resources :partials do
    post :toggle_published, on: :member
  end
  
  resources :templates do
    post :toggle_published, on: :member
  end

  root to: 'home#index'
end
