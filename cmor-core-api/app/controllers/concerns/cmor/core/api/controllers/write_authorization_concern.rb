module Cmor::Core::Api
  module Controllers
    # You can secure write endpoints so that they can only be accessed when the
    # current api token is allowed to write. This can be done by including the
    # Cmor::Core::Api::Controllers::WriteAuthorizationConcern to the
    # controller that should be secured:
    #
    #     class ApiController < ActionController::API
    #       include Cmor::Core::Api::Controllers::WriteAuthorizationConcern
    #       # ...
    #     end
    #
    # Generate a new api token:
    #
    #     # rails console
    #     > Cmor::Core::Api::ApiToken.create(can_write: true).token
    #       => "<API_TOKEN>"
    #
    # To access secured controllers you have to provide a valid token via the
    # Authorization Header:
    #
    #     GET http://localhost:3000/api/posts
    #     Authorzation: Bearer <API_TOKEN>
    #
    # If you have more writing action then create, update and destroy you can
    # secure them by adding a before_action call to your controller:
    #
    #     class ApiController < ActionController::API
    #       include Cmor::Core::Api::Controllers::WriteAuthorizationConcern
    #
    #       before_action before_action :authorize_write!, only: [:create, :update, :destroy, :destroy_all]
    #     end
    #
    # Note that you will have to list all the actions you wan't to secure in
    # the only array as the last filter definition will overwrite the previous
    # ones.
    module WriteAuthorizationConcern
      extend ActiveSupport::Concern

      included do
        before_action :authorize_write!, only: [:create, :update, :destroy]
      end

      private

      def authorize_write!
        head :forbidden unless current_api_token.can_write?
      end
    end
  end
end
