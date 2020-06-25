module Cmor::Transports
  class SystemsController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Transports::System
    end

    private

    def permitted_params
      params.require(:system).permit(:identifier, :endpoint, :api_key)
    end
  end
end
