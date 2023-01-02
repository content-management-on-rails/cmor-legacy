Cmor::Contact::Engine.routes.draw do
  resources :contact_requests, only: [:index, :destroy, :show] do
    post :notify, on: :member
  end

  root to: "home#index"
end
