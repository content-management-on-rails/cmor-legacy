require "cmor/system/backend/configuration"
require "cmor/system/backend/engine"

module Cmor
  module System
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:system_backend, Cmor::System::Backend) }