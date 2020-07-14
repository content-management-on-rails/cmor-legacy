# frozen_string_literal: true

require "aasm"
require "rao-service"
require "zip"
require "httparty"
require "rao-api-service_controller"
require "cmor_core_backend"

require "cmor/transports/version"
require "cmor/transports/configuration"
require "cmor/transports/engine"

module Cmor
  module Transports
    extend Configuration
  end
end
