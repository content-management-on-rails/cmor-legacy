require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Carousels
    module Configuration
      def configure
        yield self
      end

      # mattr_accessor(:carousel_auto_start)

      # mattr_accessor(:carousel_interval)

      # mattr_accessor(:item_image_styles) { {} }

      # mattr_accessor(:markup_languages) { [] }

      # mattr_accessor(:default_markup_language)
    end
  end
end
