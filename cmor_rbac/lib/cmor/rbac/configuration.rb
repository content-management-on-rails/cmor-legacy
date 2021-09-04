require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Rbac
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:user_class_name) { 'User' }
      mattr_accessor(:user_factory_name) { :user }

      mattr_accessor(:default_permissions_filename) do
        -> { Rails.root.join('config', 'rbac.yml') }
      end

      mattr_accessor(:authorization_failed_location) do
        -> { request.referrer || main_app.root_path }
      end

      mattr_accessor(:authorize_if_permission_is_missing) do
        -> { false }
      end

      def self.user_class
        user_class_name.constantize
      end
    end
  end
end