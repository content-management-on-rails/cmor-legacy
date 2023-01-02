require "cmor-core-api"
require "cmor-tags"
require "rao-api-resources_controller"

require "cmor/tags/api/version"
require "cmor/tags/api/configuration"
require "cmor/tags/api/engine"

module Cmor
  module Tags
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
