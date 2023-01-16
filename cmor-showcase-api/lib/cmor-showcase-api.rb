require "cmor-core-api"
require "cmor-showcase"
require "rao-api-resources_controller"

require "cmor/showcase/api/version"
require "cmor/showcase/api/configuration"
require "cmor/showcase/api/engine"

module Cmor
  module Showcase
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
