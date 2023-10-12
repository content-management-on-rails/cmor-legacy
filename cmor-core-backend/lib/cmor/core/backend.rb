require "cmor/core/backend/version"
require "cmor/core/backend/configuration"
require "cmor/core/backend/engine"

module Cmor
  module Core
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:administrador, Administrador) }
Cmor.configure { |c| c.register_configuration(:cmor_core_backend, Cmor::Core::Backend) }