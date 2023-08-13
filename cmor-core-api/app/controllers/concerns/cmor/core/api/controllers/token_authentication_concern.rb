module Cmor::Core::Api
  module Controllers
    # You can secure endpoints so that they can only be accessed with a valid
    # api token. This can be done by including the
    # Cmor::Core::Api::Controllers::TokenAuthenticationConcern to the
    # controller that should be secured:
    #
    #     class ApiController < ActionController::API
    #       include Cmor::Core::Api::Controllers::TokenAuthenticationConcern
    #
    #       before_action :authenticate_with_token!
    #       # ...
    #     end
    #
    # Generate a new api token:
    #
    #     # rails console
    #     > Cmor::Core::Api::ApiToken.create.token
    #       => "<API_TOKEN>"
    #
    # To access secured controllers you have to provide a valid token via the
    # Authorization Header:
    #
    #     GET http://localhost:3000/api/posts
    #     Authorzation: Bearer <API_TOKEN>
    #
    module TokenAuthenticationConcern
      extend ActiveSupport::Concern

      included do
        include ActionController::HttpAuthentication::Token::ControllerMethods

        attr_reader :current_api_token
      end

      private

      def authenticate_with_token!
        unless authenticate_with_http_token { |t, o| @current_api_token = ApiToken.authenticate(t, o) }
          request_http_token_authentication
        end
      end
    end
  end
end
