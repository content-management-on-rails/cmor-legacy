module Cmor
  module Rbac
    module Backend
      class PermissionsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Cmor::Rbac::Permission
        end

        private

        def permitted_params
          params.require(:permission).reject! { |k,v| k == 'user_ids' }.permit(:identifier, :enabled_from, :enabled_to, role_ids: [])
        end
      end
    end
  end
end