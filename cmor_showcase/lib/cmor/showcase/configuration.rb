module Cmor::Showcase
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
  end
end
