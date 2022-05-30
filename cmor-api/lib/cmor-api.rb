require "cmor/api/version"
require "cmor/api/configuration"
require "cmor/api/engine"

module Cmor
  module Api
    def self.configure
      yield Configuration
    end
  end
end
