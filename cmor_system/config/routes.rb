Cmor::System::Engine.routes.draw do
  resources :changelogs, only: [:index, :show]
  resources :delayed_backend_active_record_jobs if Cmor::System::Configuration.enable_delayed_job_backend
  namespace :active_storage do
    resources :blobs , only: [:index, :show, :destroy] do
      Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    end
    resources :attachments , only: [:index, :show, :destroy] do
      Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
    end
  end if Cmor::System::Configuration.enable_active_storage_backend

  root to: 'home#index'
end
