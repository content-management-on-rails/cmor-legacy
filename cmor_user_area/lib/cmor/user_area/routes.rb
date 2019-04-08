module Cmor
  module UserArea
    module Routes
      def self.routes(r)
        r.resource :current_user, only: [:show, :edit, :update]
        r.resource :current_user, only: [:new, :create] if Cmor::UserArea::Configuration.enable_registrations
        r.resource :current_user, only: [:destroy] if Cmor::UserArea::Configuration.allow_users_to_destroy_self
        r.resource :user_password_reset_request, only: [:new, :create]

        r.resource :user_password_reset, only: [] do
          r.get 'edit/:token' => 'user_password_resets#edit', constraint: { token: /\d+/ }, as: :edit
          r.match '/:id/:token' => 'user_password_resets#update', constraint: { token: /\d+/ }, as: :update, via: [:put, :patch]
        end

        r.resource :user_session, only: [:new, :create, :destroy]

        r.root to: 'user#show'
      end
    end
  end
end
