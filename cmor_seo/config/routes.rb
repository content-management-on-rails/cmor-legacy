Cmor::Seo::Engine.routes.draw do
  resources :items do
    acts_as_published
    post :autocomplete_resource, on: :collection
    post :destroy_many, on: :collection
  end
  resources :meta_tags do
    acts_as_list
    acts_as_published
  end

  root to: 'home#index'
end
