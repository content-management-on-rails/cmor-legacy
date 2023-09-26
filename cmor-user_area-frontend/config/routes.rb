Cmor::UserArea::Frontend::Engine.routes.draw do
  localized do
    scope :cmor_user_area_frontend_engine do
      resource :current_user, only: [:show, :edit, :update] do
        post "trigger_event/:machine_name/:event_name", on: :member, action: "trigger_event", as: :trigger_event
        resource :two_factor_authentication_setup_service, only: [:new, :create] if Cmor::UserArea::Configuration.tfa_enabled?
      end
      resource :current_user, only: [:new, :create] if Cmor::UserArea::Configuration.enable_registrations
      resource :current_user, only: [:destroy] if Cmor::UserArea::Configuration.allow_users_to_destroy_self
      resource :user_password_reset_request, only: [:new, :create]

      resource :user_password_reset, only: [] do
        get "edit/:token" => "user_password_resets#edit", :constraint => {token: /\d+/}, :as => :edit
        match "/:id/:token" => "user_password_resets#update", :constraint => {token: /\d+/}, :as => :update, :via => [:put, :patch]
      end

      resource :user_sessions, only: [:new, :create, :destroy]
      resource :user_two_factor_authentications, only: [:new, :create] if Cmor::UserArea::Configuration.tfa_enabled?

      root to: "current_users#show"
    end
  end
end
