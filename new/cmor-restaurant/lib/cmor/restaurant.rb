require "acts_as_published"

require "cmor/restaurant/version"
require "cmor/restaurant/configuration"
require "cmor/restaurant/engine"

module Cmor
  module Restaurant
    def self.configure
      yield Configuration
    end
  end
end
