module Cmor
  module Core
    module Api
      module Backend
        class ApiTokensController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            Cmor::Core::Api::ApiToken
          end

          private

          def permitted_params
            params.require(:api_token).permit(:can_write, :description, :active_from, :active_to)
          end

          def after_create_location
            flash[:success] = t(".token_info_html", token: @resource.token)
            nil
          end
        end
      end
    end
  end
end
