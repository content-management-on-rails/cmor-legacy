Cmor::Carousels::Engine.routes.draw do
  resources :carousels
  resources :item_details, only: [:index, :show, :edit, :update, :destroy] do
    post :destroy_many, on: :collection
    post :toggle_published, on: :member
    post :reposition, on: :member
  end

  root to: 'home#index'
end
