require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Links
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :link_footer_columns do
        4
      end

      mattr_accessor :link_footer_wrapper_css_classes do
        %w( row link-footer )
      end

      mattr_accessor :link_footer_column_css_classes do
        %w( link-footer-column col-lg-3 )
      end

      mattr_accessor :base_controller do
        'ApplicationController'
      end
    end
  end
end
