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

        mattr_accessor(:mutations) {}
        mattr_accessor(:models) {}
        mattr_accessor(:services) {}
      end
    end
  end
end
