require "cmor-core-backend"
require "request_store"
require "rao-service"

require "cmor/multi_tenancy"
require "cmor/multi_tenancy/version"
require "cmor/multi_tenancy/configuration"
require "cmor/multi_tenancy/engine"

module Cmor
  module MultiTenancy
    extend Configuration
  end
end
