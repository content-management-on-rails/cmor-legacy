require "cmor-core-api"
require "cmor-links"
require "rao-api-resources_controller"

require "cmor/links/api/version"
require "cmor/links/api/configuration"
require "cmor/links/api/engine"

module Cmor
  module Links
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
