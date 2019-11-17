Cmor::Contact::Engine.routes.draw do
  localized do
    scope :cmor_contact_engine do
      resources :contact_requests, only: [:create, :index]
      resources :whatsapp_requests, only: [:create, :index]

      root to: 'contact_requests#index'
    end
  end
end
