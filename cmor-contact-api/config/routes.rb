Cmor::Contact::Api::Engine.routes.draw do
  resource :contact_requests, only: [:create]
end
