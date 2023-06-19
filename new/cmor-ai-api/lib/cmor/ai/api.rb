require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/ai/api/version"
require "cmor/ai/api/configuration"
require "cmor/ai/api/engine"

module Cmor
  module Ai
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
