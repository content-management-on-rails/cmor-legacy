require "cmor/core/api/version"
require "cmor/core/api/configuration"
require "cmor/core/api/engine"

module Cmor
  module Core
    module Api
      def self.configure
        yield Configuration
      end
    end
  end
end
