require "cmor-core-api"
require "cmor-cms"
require "rao-api-resources_controller"

require "cmor/cms/api/version"
require "cmor/cms/api/configuration"
require "cmor/cms/api/engine"

module Cmor
  module Cms
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
