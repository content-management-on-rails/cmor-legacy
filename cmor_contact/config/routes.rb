Cmor::Contact::Engine.routes.draw do
  resources :contact_requests, only: [:index, :delete, :show] do
    post :notify, on: :member
  end

  root to: 'home#index'
end
