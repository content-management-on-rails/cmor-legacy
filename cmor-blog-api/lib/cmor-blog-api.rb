require "cmor-core-api"
require "cmor-blog"
require "rao-api-resources_controller"

require "cmor/blog/api/version"
require "cmor/blog/api/configuration"
require "cmor/blog/api/engine"

module Cmor
  module Blog
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
