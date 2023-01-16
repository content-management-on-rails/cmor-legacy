Cmor::Seo::Engine.routes.draw do
  resources :items do
    acts_as_published
    get :autocomplete_resource, on: :collection
    post :destroy_many, on: :collection
  end
  resources :meta_tags do
    acts_as_list
    acts_as_published
    post :destroy_many, on: :collection
  end
  resources :generate_resource_classes_meta_tags_service, only: [:new, :create]

  root to: "home#index"
end
