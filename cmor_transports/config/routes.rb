Cmor::Transports::Engine.routes.draw do
  resources :exports do
    post :destroy_many, on: :collection
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  resources :outgoings do
    post :destroy_many, on: :collection
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  resources :incomings do
    post :destroy_many, on: :collection
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  resources :systems do
    post :destroy_many, on: :collection
  end

  namespace :api do
    namespace :incoming do
      resources :create_services, only: [:create]
      resources :show_services, only: [:create]
    end
  end

  resource :export_sidebar, only: [:show]

  root to: 'home#index'
end
