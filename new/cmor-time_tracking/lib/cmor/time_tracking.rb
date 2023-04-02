require "cmor/time_tracking/version"
require "cmor/time_tracking/configuration"
require "cmor/time_tracking/engine"

module Cmor
  module TimeTracking
    def self.configure
      yield Configuration
    end
  end
end
