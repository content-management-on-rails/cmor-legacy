Cmor::Links::Engine.routes.draw do
  localized do
    scope :cmor_links_engine do
      resources :categories, only: [:index, :show]
    end
  end
end