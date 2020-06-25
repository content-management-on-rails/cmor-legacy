Cmor::Transports::Engine.routes.draw do
  resources :exports do
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end
  resources :outgoings do
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  namespace :api do
    namespace :incoming do
      resources :create_services, only: [:create]
      resources :show_services, only: [:create]
    end
  end

  resources :systems

  resource :export_sidebar, only: [:show]

  root to: 'home#index'
end
