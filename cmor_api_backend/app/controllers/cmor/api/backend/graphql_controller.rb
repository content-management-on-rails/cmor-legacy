module Cmor
  module Api
    module Backend
      class GraphqlController < ApplicationController
        # If accessing from outside this domain, nullify the session
        # This allows for outside API access while preventing CSRF attacks,
        # but you'll have to authenticate your user separately
        # protect_from_forgery with: :null_session
        protect_from_forgery with: :null_session

        include ::Cmor::Api::GraphqlController::BaseConcern
        include ::Cmor::UserArea::Controller::BearerAuthenticationConcern

        def self.schema_class
          Cmor::Api::Backend::Schema
        end

        private


        def context
          default_context.merge(current_user: @current_user)
        end
      end
    end
  end
end
