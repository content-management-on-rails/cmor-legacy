require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/time_tracking/api/version"
require "cmor/time_tracking/api/configuration"
require "cmor/time_tracking/api/engine"

module Cmor
  module TimeTracking
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
