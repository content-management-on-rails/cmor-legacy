module Cmor
  module Api
    module GraphqlController
      module BearerAuthenticationConcern
        extend ActiveSupport::Concern

        included do
          before_action :load_current_user, if: -> { request.headers['Authorization'].present? }
        end

        private

        def load_current_user
          @current_user = Cmor::UserArea::User.authenticable.where(single_access_token: request.headers['Authorization'].split(" ").last).first
        end
      end
    end
  end
end
