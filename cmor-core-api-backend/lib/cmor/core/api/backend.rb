require "cmor_core_backend"

require "cmor/core/api/backend/version"
require "cmor/core/api/backend/configuration"
require "cmor/core/api/backend/engine"

module Cmor
  module Core
    module Api
      module Backend
        def self.configure
          yield Configuration
        end
      end
    end
  end
end
