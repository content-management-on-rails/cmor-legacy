module Cmor
  module MultiTenancy
    class ClientsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsListConcern

      def self.resource_class
        Cmor::MultiTenancy::Client
      end

      private

      def permitted_params
        params.require(:client).permit(:identifier, :title, :description, :active_from, :active_to)
      end
    end
  end
end
