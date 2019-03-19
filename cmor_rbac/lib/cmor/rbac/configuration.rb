require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Cmor
  module Rbac
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:user_class_name) { 'User' }

      mattr_accessor(:default_permissions_filename) { -> { Rails.root.join('config', 'rbac.yml') }  }

      def self.user_class
        user_class_name.constantize
      end
    end
  end
end