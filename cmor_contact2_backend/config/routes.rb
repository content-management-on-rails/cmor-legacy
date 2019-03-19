Cmor::Contact::Backend::Engine.routes.draw do
  resources :contact_requests, only: [:index, :edit, :update, :delete, :show] do
    post :notify, on: :member
  end

  root to: 'home#index'
end
