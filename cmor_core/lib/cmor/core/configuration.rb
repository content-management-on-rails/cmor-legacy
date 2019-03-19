require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Core
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:base_controller) { '::FrontendController' }
      mattr_accessor(:markup_languages) {  %w[ markdown rdoc textile ] }
      mattr_accessor(:default_markup_language) { 'textile' }
    end
  end
end
