require "cmor/ai/version"
require "cmor/ai/configuration"
require "cmor/ai/engine"

module Cmor
  module Ai
    def self.configure
      yield Configuration
    end
  end
end
