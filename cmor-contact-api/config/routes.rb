Cmor::Contact::Api::Engine.routes.draw do
  resources :contact_requests do
    post :validate, on: :collection
  end
end
