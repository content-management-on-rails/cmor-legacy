require "cmor-core-backend"

require "cmor/tags/version"
require "cmor/tags/configuration"
require "cmor/tags/engine"

module Cmor
  module Tags
    def self.configure
      yield Configuration
    end
  end
end
