Cmor::Transports::Engine.routes.draw do
  resources :exports do
    post 'trigger_event/:machine_name/:event_name', on: :member, action: 'trigger_event', as: :trigger_event
  end

  root to: 'home#index'
end
