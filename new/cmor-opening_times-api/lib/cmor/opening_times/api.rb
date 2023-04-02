require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/opening_times/api/version"
require "cmor/opening_times/api/configuration"
require "cmor/opening_times/api/engine"

module Cmor
  module OpeningTimes
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
