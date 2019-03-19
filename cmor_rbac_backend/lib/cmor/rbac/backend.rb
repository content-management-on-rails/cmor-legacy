require 'cmor/rbac/backend/configuration'
require 'cmor/rbac/backend/engine'

module Cmor
  module Rbac
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:rbac_backend, Cmor::Rbac::Backend) }