require "cmor-core-api"
require "rao-api-resources_controller"

require "cmor/faq/api/version"
require "cmor/faq/api/configuration"
require "cmor/faq/api/engine"

module Cmor
  module Faq
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
