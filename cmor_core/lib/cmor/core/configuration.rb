require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:default_markup_options) { { processor: :markdown } }
    end
  end
end
