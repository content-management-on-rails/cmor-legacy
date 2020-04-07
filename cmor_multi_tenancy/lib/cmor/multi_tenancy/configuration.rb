module Cmor::MultiTenancy
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

    mattr_accessor :current_client_key do
      :subdomain
    end

    mattr_accessor :aliases_for_default_client do
      %w( www )
    end
  end
end
