require "cmor-core-api"
require "cmor-contact"
require "rao-api-resources_controller"

require "cmor/contact/api/version"
require "cmor/contact/api/configuration"
require "cmor/contact/api/engine"

module Cmor
  module Contact
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
