Cmor::Files::Engine.routes.draw do
  localized do
    scope :cmor_files_engine do
      resources :folders

      root to: 'folders#index'
    end
  end
end
