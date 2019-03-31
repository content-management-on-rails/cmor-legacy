require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Backend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:image_variant_options) {
          {
            gallery: { resize: "640x480" },
            table:   { resize: "160x120" }
          }
        }

        def self.image_variant_options_for(identifier)
          @@image_variant_options[identifier]
        end
      end
    end
  end
end
