require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module Blog
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:base_controller) do
        '::FrontendController'
      end

      mattr_accessor(:creator_class_name) do
        'User'
      end

      mattr_accessor(:user_factory_name) do
        :user
      end

      mattr_accessor(:posts_index_page_title_proc) do
        ->(view) { view.resource_class.model_name.human(count: :other) }
      end

      mattr_accessor(:pagination_options_proc) do
        ->(view) { { theme: 'twitter-bootstrap-3' } }
      end
      mattr_accessor(:preview_picture_asset_variant_options) do
        { resize: '320x240' }
      end

      mattr_accessor(:creator_label_method_name) do
        :to_s
      end
    end
  end
end
