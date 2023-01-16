require "cmor-core-api"
require "cmor-seo"
require "rao-api-resources_controller"

require "cmor/seo/api/version"
require "cmor/seo/api/configuration"
require "cmor/seo/api/engine"

module Cmor
  module Seo
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
