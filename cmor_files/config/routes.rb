Cmor::Files::Engine.routes.draw do
  localized do
    scope :cmor_files_engine do
      resources :folders
    end
  end
end
