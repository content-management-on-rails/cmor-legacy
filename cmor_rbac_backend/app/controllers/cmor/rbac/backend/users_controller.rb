module Cmor
  module Rbac
    module Backend
      class UsersController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Cmor::Rbac::Configuration.user_class
        end

        def self.available_rest_actions
          super - %i(new)
        end

        private

        def permitted_params
          params.require(:user).permit(role_ids: [])
        end
      end
    end
  end
end
