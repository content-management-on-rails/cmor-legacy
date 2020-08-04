require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Tags
    module Configuration
      def configure
        yield self
      end
      mattr_accessor(:base_controller) { 'FrontendController' }
      mattr_accessor(:add_submit_button_to_search_box) { true }
      mattr_accessor(:tag_search_exact_default_value) { false }
      mattr_accessor(:taggable_class_names) { [] }
      mattr_accessor(:taggable_factory_name) { :cmor_blog_post }

      def self.taggable_classes
        @@taggable_class_names.map(&:constantize)
      end
    end
  end
end
