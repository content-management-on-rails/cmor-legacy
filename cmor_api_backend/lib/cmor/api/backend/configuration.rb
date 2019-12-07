require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Api
    module Backend
      module Configuration
        def configure
          yield self
        end
      end
    end
  end
end
