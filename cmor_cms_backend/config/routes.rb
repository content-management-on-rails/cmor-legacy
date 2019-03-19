Cmor::Cms::Backend::Engine.routes.draw do
  resources :add_homepages_service, only: [:create, :new]
  resources :import_partials_service, only: [:create, :new]

  # backend_resources :content_boxes
  # backend_resources :navigations
  # backend_resources :navigation_items do
  #   post :reposition, on: :member
  # end
  # backend_resources :pages
  # backend_resources :partials
  # backend_resources :templates

  resources :content_boxes
  resources :navigations
  resources :navigation_items do
    post :reposition, on: :member
  end
  resources :pages
  resources :partials
  resources :templates

  root to: 'home#index'
end
