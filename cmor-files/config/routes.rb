Cmor::Files::Engine.routes.draw do
  resources :attachments do
    post :destroy_many, on: :collection
  end

  resources :folders do
    acts_as_list
    acts_as_published
    post :destroy_many, on: :collection
    post :unpublish_many, on: :collection
    post :publish_many, on: :collection
  end

  resources :file_details, except: [:new, :create] do
    acts_as_list
    acts_as_published
    post :destroy_many, on: :collection
    post :unpublish_many, on: :collection
    post :publish_many, on: :collection
  end

  root to: "home#index"
end
