require 'cmor/rbac/configuration'
require 'cmor/rbac/engine'

module Cmor
  module Rbac
    extend Configuration

    def self.table_name_prefix
      'cmor_rbac_'
    end
  end
end

Cmor.configure { |c| c.register_configuration(:rbac, Cmor::Rbac) }