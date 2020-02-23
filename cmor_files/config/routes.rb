Cmor::Files::Engine.routes.draw do
  localized do
    scope :cmor_files_engine do
      resources :folders, only: [ :index, :show ]
      resources :file_details, only: [ :index, :show ]

      root to: 'folders#index'
    end
  end
end
