Cmor::UserArea::Engine.routes.draw do
  resources :create_default_user_service, only: [:new, :create]

  resources :users do
    get :autocomplete, on: :collection
    post "trigger_event/:machine_name/:event_name", on: :member, action: "trigger_event", as: :trigger_event
  end

  resource :current_user, only: [:show]
  resource :user_sidebar, only: [:show]

  root to: "home#index"
end
