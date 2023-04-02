require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/restaurant/api/version"
require "cmor/restaurant/api/configuration"
require "cmor/restaurant/api/engine"

module Cmor
  module Restaurant
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
