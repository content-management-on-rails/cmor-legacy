module Cmor
  module Rbac
    module Backend
      class RolesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Cmor::Rbac::Role
        end

        private

        def permitted_params
          params.require(:role).permit(:identifier, :enabled_from, :enabled_to, permission_ids: [], user_ids: [])
        end
      end
    end
  end
end
