require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module System
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:registered_controllers) { -> {[]} }
      mattr_accessor(:registered_services) { -> {[]} }
      mattr_accessor(:enable_active_storage_backend) { false }
      mattr_accessor(:enable_delayed_job_backend) { false }
      mattr_accessor(:record_factory_name) { 'user' }
      mattr_accessor(:record_attachment_name) { 'asset' }

      def self.registered_controllers
        rc = @@registered_controllers.call
        rc.reject! { |c| c.name =~ /.*ActiveStorage.*/ } unless enable_active_storage_backend
        rc.reject! { |c| c.name =~ /.*Delayed.*/ } unless enable_delayed_job_backend
        -> { rc }
      end
    end
  end
end
