require "cmor-core-api"
require "cmor-legal"
require "rao-api-resources_controller"

require "cmor/legal/api/version"
require "cmor/legal/api/configuration"
require "cmor/legal/api/engine"

module Cmor
  module Legal
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
