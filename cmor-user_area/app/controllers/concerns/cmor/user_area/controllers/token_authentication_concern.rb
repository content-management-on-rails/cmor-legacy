module Cmor
  module UserArea
    module Controllers
      # You can secure endpoints so that they can only be accessed with the
      # single access token of a Cmor::UserArea::User. This can be done by
      # including the Cmor::UserArea::Controllers::TokenAuthenticationConcern
      # to the controller that should be secured:
      #
      #     class ApiController < ActionController::API
      #       include Cmor::UserArea::Controllers::TokenAuthenticationConcern
  
      #       before_action :authenticate_with_single_access_token!
      #       # ...
      #     end
      #
      # Generate a new api token:
      #
      #     # rails console
      #     > Cmor::UserArea::User.first.single_access_token
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
        end
  
        private
  
        def authenticate_user_with_single_access_token!
          unless authenticate_with_http_token { |t, o| @current_user = Cmor::UserArea::User.authenticate_with_single_access_token(t, o) }
            request_http_token_authentication
          end
        end
      end
#      module TokenAuthenticationConcern
#        extend ActiveSupport::Concern
#
#        included do
#          before_action :authenticate_user_from_token!
#        end
#
#        private
#
#        def authenticate_user_from_token!
#          user_token = params[:user_token].presence
#          user       = user_token && Cmor::UserArea::User.find_by_authentication_token(user_token.to_s)
#
#          if user
#            sign_in user, store: false
#          end
        end
      end
    end