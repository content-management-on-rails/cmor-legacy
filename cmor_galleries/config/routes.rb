Cmor::Galleries::Engine.routes.draw do
  localized do
    scope :cmor_galleries_engine do
      resources :picture_galleries do
        post :toggle_published, on: :member
      end

      root to: 'picture_galleries#index'
    end
  end
end
