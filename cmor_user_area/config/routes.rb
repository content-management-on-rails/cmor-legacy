Cmor::UserArea::Engine.routes.draw do
  localized do
    scope :cmor_user_area_engine do
      resource :current_user, only: [:show, :edit, :update]
      resource :current_user, only: [:new, :create] if Cmor::UserArea::Configuration.enable_registrations
      resource :current_user, only: [:destroy] if Cmor::UserArea::Configuration.allow_users_to_destroy_self
      resource :user_password_reset_request, only: [:new, :create]

      resource :user_password_reset, only: [] do
        get 'edit/:token' => 'user_password_resets#edit', constraint: { token: /\d+/ }, as: :edit
        match '/:id/:token' => 'user_password_resets#update', constraint: { token: /\d+/ }, as: :update, via: [:put, :patch]
      end

      resource :user_session, only: [:new, :create, :destroy]

      root to: 'user#show'
    end
  end
end
