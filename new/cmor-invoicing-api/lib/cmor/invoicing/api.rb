require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/invoicing/api/version"
require "cmor/invoicing/api/configuration"
require "cmor/invoicing/api/engine"

module Cmor
  module Invoicing
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
