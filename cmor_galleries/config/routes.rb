Cmor::Galleries::Engine.routes.draw do
  localized do
    scope :cmor_galleries_engine do
      resources :picture_galleries do
        post :toggle_published, on: :member
      end
    end
  end
end
