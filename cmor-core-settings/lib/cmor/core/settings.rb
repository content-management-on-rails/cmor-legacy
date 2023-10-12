require "cmor/core/settings/engine"
require "cmor/core/settings/settable"
require "cmor/core/settings/configuration"
require "cmor/core/settings/version"

module Cmor
  module Core
    module Settings
      def self.configure
        yield Configuration
      end

      def self.get(namespace, key)
        settable = Cmor::Core::Settings::Settable.where(namespace: namespace, key: key).first!
        settable.value
      end

      def self.set(namespace, key, value)
        settable = Cmor::Core::Settings::Settable.where(namespace: namespace, key: key).first!
        settable.update!(value: value)
      end
    end
  end
end
