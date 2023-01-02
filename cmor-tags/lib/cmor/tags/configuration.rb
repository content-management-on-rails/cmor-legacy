module Cmor
  module Tags
    class Configuration
      class << self
        extend Forwardable

        attr_accessor :values

        def define_option(key, default: nil)
          @values[key] = default
          define_singleton_method(key) do
            @values[key]
          end

          define_singleton_method("#{key}=") do |value|
            @values[key] = value
          end
        end
      end

      @values = {}

      define_option :resources_controllers, default: -> { [] }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> { [] }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :tagger_class_names, default: []
      define_option :taggable_class_names, default: []
      define_option :taggable_factory_name, default: :cmor_blog_post
      define_option :tag_search_exact_default_value, default: false

      def self.taggable_classes
        @values[:taggable_class_names].map(&:constantize)
      end

      def self.tagger_classes
        @values[:tagger_class_names].map(&:constantize)
      end
    end
  end
end
