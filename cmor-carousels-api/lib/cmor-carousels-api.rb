require "cmor-core-api"
require "cmor-carousels"
require "rao-api-resources_controller"

require "cmor/carousels/api/version"
require "cmor/carousels/api/configuration"
require "cmor/carousels/api/engine"

module Cmor
  module Carousels
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
