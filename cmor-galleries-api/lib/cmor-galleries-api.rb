require "cmor-core-api"
require "cmor-galleries"
require "rao-api-resources_controller"

require "cmor/galleries/api/version"
require "cmor/galleries/api/configuration"
require "cmor/galleries/api/engine"

module Cmor
  module Galleries
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
