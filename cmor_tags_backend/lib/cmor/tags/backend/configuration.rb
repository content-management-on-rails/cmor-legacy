require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Tags
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :registered_controllers do
          -> { [] }
        end

        mattr_accessor :registered_services do
          -> { [] }
        end

        mattr_accessor(:taggable_class_names) { [] }
        mattr_accessor(:tagger_class_names)   { [] }

        def self.taggable_classes
          @@taggable_class_names.map(&:constantize)
        end

        def self.tagger_classes
          @@tagger_class_names.map(&:constantize)
        end
      end
    end
  end
end
