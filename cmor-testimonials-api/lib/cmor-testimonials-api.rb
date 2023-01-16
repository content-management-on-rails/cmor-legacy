require "cmor-core-api"
require "cmor-testimonials"
require "rao-api-resources_controller"

require "cmor/testimonials/api/version"
require "cmor/testimonials/api/configuration"
require "cmor/testimonials/api/engine"

module Cmor
  module Testimonials
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
