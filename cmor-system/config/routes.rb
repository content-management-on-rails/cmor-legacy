Cmor::System::Engine.routes.draw do
  resources :changelogs, only: [:index, :show]
  if Cmor::System::Configuration.enable_delayed_job_backend
    namespace :delayed do
      namespace :backend do
        namespace :active_record do
          resources :jobs, only: [:index, :show, :edit, :update, :destroy] do
            Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
          end
        end
      end
    end
  end
  if Cmor::System::Configuration.enable_active_storage_backend
    namespace :active_storage do
      resources :blobs, only: [:index, :show, :destroy] do
        Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
      end
      resources :attachments, only: [:index, :show, :destroy] do
        Cmor::Core::Backend::Routing::ResourcesRoutes.inject_routes(self)
      end
    end
  end

  if Cmor::System::Configuration.enable_active_storage_backend
    namespace :rack do
      namespace :attack do
        resources :banned_ips, only: [:index, :show, :new, :create, :destroy]
      end
    end
  end

  root to: "home#index"
end
