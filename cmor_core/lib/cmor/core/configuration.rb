require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:default_markup_options) { { processor: :markdown } }

      mattr_accessor(:features) { {} }

      def enable_feature(name, options = {})
        @@features[name] = Cmor::Core::Feature.new(name, options)
      end

      def features?(name)
        @@features.has_key?(name)
      end
    end
  end
end
