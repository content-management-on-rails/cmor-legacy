Cmor::Showcase::Engine.routes.draw do
  resources :categories do
    acts_as_published
    acts_as_list
  end

  resources :items do
    acts_as_published
    acts_as_list
  end

  resources :file_details do
    post :destroy_many, on: :collection
    acts_as_list
  end

  root to: 'home#index'
end
