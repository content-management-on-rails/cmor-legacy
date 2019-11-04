module Cmor::Seo
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :resources_controllers do
      -> {[]}
    end

    mattr_accessor :resource_controllers do
      -> {[]}
    end

    mattr_accessor :service_controllers do
      -> {[]}
    end

    mattr_accessor :sidebar_controllers do
      -> {[]}
    end

    mattr_accessor :items_resource_autocomplete_options do
      {}
    end
  end
end
