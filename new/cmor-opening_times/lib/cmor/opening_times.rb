require "cmor/opening_times/version"
require "cmor/opening_times/configuration"
require "cmor/opening_times/engine"

module Cmor
  module OpeningTimes
    def self.configure
      yield Configuration
    end
  end
end
