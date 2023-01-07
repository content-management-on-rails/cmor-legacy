require "cmor-core-api"
require "cmor-user_area"
require "rao-api-resources_controller"

require "cmor/user_area/api/version"
require "cmor/user_area/api/configuration"
require "cmor/user_area/api/engine"

module Cmor
  module UserArea
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
