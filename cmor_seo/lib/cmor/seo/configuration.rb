# frozen_string_literal: true

module Cmor::Seo
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :resources_controllers do
      -> { [] }
    end

    mattr_accessor :resource_controllers do
      -> { [] }
    end

    mattr_accessor :service_controllers do
      -> { [] }
    end

    mattr_accessor :sidebar_controllers do
      -> { [] }
    end

    mattr_accessor :resources do
      {}
    end

    mattr_accessor :handle_seoable_after_save_exception do
      ->(exception) { raise exception }
    end

    def self.resources_autocomplete_options
      resources.each_with_object({}) { |(k, v), m| m[k] = v.fetch(:autocomplete_options) { {} } }
    end

    def add_resource(class_name, options = {})
      @@resources[class_name] = options
    end

    def remove_resource(*class_names)
      class_names.each do |class_name|
        @resources.delete(class_name)
      end
    end
  end
end
