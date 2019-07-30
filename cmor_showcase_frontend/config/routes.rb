Cmor::Showcase::Frontend::Engine.routes.draw do
  localized do
    scope :cmor_showcase_frontend_engine do
      resources :categories, only: [:index, :show]
      resources :items, only: [:show]
      root to: 'categories#index'
    end
  end
end
