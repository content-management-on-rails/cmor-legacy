require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Testimonials
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:image_variant_options) { {} }
    end
  end
end
