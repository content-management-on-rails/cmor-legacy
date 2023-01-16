Cmor::Testimonials::Engine.routes.draw do
  resources :categories
  resources :testimonials do
    post :destroy_many, on: :collection
    post :toggle_published, on: :member
    post :reposition, on: :member
  end

  root to: "home#index"
end
