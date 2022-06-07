module Cmor::Core::Api
  module Controllers
    module TokenAuthenticationConcern
      extend ActiveSupport::Concern

      included do
        include ActionController::HttpAuthentication::Token::ControllerMethods
        before_action :authenticate_with_token!
      end

      private

      def authenticate_with_token!
        unless authenticate_with_http_token { |t, o| ApiToken.authenticate(t, o) }
          request_http_token_authentication
        end
      end
    end
  end
end
