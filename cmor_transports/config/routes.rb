Cmor::Transports::Engine.routes.draw do
  resources :exports do
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  resource :export_sidebar, only: [:show]

  root to: 'home#index'
end
