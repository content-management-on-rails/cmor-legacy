module Cmor
  module Blog
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

      define_option :resources_controllers, default: -> {[]}
      define_option :resource_controllers, default: -> {[]}
      define_option :service_controllers, default: -> {[]}
      define_option :sidebar_controllers, default: -> {[]}
      define_option :current_user_proc, default: ->(controller) { controller.current_user }
      define_option :user_factory_name, default: :user
      define_option :creator_class_name, default: 'User'
    end
  end
end
