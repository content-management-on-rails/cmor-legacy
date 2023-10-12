require "cmor/system/configuration"
require "cmor/system/engine"

module Cmor
  module System
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:system, Cmor::System) }
