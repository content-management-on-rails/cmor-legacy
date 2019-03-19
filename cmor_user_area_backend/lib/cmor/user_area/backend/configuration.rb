require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module UserArea
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :resources_controllers do
          -> {[]}
        end

        mattr_accessor :service_controllers do
          -> {[]}
        end

        mattr_accessor :sidebar_controllers do
          -> {[]}
        end
      end
    end
  end
end
