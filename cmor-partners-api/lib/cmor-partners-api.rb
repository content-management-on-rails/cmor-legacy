require "cmor-core-api"
require "cmor-partners"
require "rao-api-resources_controller"

require "cmor/partners/api/version"
require "cmor/partners/api/configuration"
require "cmor/partners/api/engine"

module Cmor
  module Partners
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
