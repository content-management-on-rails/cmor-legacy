require "cmor-core-api"
require "cmor-files"
require "rao-api-resources_controller"

require "cmor/files/api/version"
require "cmor/files/api/configuration"
require "cmor/files/api/engine"

module Cmor
  module Files
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
