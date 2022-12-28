Cmor::Galleries::Engine.routes.draw do
  resources :picture_galleries do
    acts_as_list
    acts_as_published
  end

  resources :picture_details, except: [:new] do
    post :destroy_many, on: :collection
    acts_as_list
    acts_as_published
  end

  root to: "home#index"
end
