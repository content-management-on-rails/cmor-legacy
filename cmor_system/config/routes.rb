Cmor::System::Engine.routes.draw do
  resources :delayed_backend_active_record_jobs if Cmor::System::Configuration.enable_delayed_job_backend
  namespace :active_storage do
    resources :blobs , only: [:index, :show, :destroy]
    resources :attachments , only: [:index, :show, :destroy]
  end if Cmor::System::Configuration.enable_active_storage_backend

  root to: 'home#index'
end
