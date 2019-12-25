Cmor::Contact::Frontend::Engine.routes.draw do
  localized do
    scope :cmor_contact_frontend_engine do
      resources :contact_requests, only: [:create, :index]
      resources :whatsapp_requests, only: [:create, :index]

      root to: 'contact_requests#index'
    end
  end
end
