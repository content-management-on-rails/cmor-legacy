require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Cms
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :base_controller do
        'ApplicationController'
      end

      mattr_accessor :default_handlers do
        HashWithIndifferentAccess.new
      end

      mattr_accessor :site_title do
        ''
      end

      mattr_accessor :navigation_item_properties do
        []
      end

      mattr_accessor(:navigation_locale_fallback) { ->(navigation_name, locale) {false} }

      def default_handlers=(default_handlers)
        @@default_handlers = HashWithIndifferentAccess.new(default_handlers)
      end
    end
  end
end
