Cmor::Files::Backend::Engine.routes.draw do
  resources :attachments do
    post :destroy_many, on: :collection
  end

  resources :folders do
    post :toggle_published, on: :member
    post :destroy_many, on: :collection
    post :unpublish_many, on: :collection
    post :publish_many, on: :collection
  end

  resources :file_details do
    post :destroy_many, on: :collection
  end

  root to: 'home#index'
end
