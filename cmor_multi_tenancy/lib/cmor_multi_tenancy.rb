require "cmor_core_backend"
require "request_store"
require "rao-service"

require "cmor/multi_tenancy"
require "cmor/multi_tenancy/configuration"
require "cmor/multi_tenancy/engine"

module Cmor
  module MultiTenancy
    extend Configuration
  end
end
