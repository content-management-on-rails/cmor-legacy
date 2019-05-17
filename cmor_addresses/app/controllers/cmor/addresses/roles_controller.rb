module Cmor::Addresses
  class RolesController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Addresses::Role
    end

    private

    def permitted_params
      params.require(:role).permit(:identifier, :name)
    end
  end
end