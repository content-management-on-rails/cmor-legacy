require "cmor/core/backend/configuration"
require "cmor/core/backend/engine"

module Cmor
  module Core
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:core_backend, Cmor::Core::Backend) }
Cmor.configure { |c| c.register_configuration(:administrador, Administrador) }