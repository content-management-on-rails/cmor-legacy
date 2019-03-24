Cmor::Core::Backend::Engine.routes.draw do
  resources :delayed_backend_active_record_jobs if Cmor::Core::Backend::Configuration.enable_delayed_job_backend
  namespace :active_storage do
    resources :blobs
    resources :attachments
  end if Cmor::Core::Backend::Configuration.enable_active_storage_backend

  root to: 'home#index'
end
