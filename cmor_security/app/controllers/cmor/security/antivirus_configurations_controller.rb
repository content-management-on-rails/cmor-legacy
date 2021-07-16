module Cmor
  module Security
    class AntivirusConfigurationsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Cmor::Security::AntivirusConfiguration
      end

      def self.available_rest_actions
        [:index]
      end
    end
  end
end
