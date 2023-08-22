require "cmor/core/feature"
require "cmor/core/configuration"
require "cmor/core/engine"
require "cmor/core/version"
require "cmor/core/active_collection/base"

module Cmor
  module Core
    extend Configuration

    module RemoteIpConcern
      extend ActiveSupport::Concern

      class_methods do
        def remote_ip
          RequestLocals.fetch(:remote_ip) { nil }
        end
      end
    end

    include RemoteIpConcern
  end
end

Cmor.configure { |c| c.register_configuration(:core, Cmor::Core) }