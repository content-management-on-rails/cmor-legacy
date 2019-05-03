Cmor::Partners::Frontend::Engine.routes.draw do
  localized do
    scope :cmor_partners_frontend_engine do
      resources :categories
      resources :partners, only: [:show]
      root to: 'categories#index'
    end
  end
end
