# frozen_string_literal: true

module Cmor
  module Legal
    class CookieStore
      attr_writer :cookies

      def initialize(store)
        @store = store
      end

      def self.cookie_prefix
        ::Cmor::Legal::Configuration.cookie_prefix
      end

      def self.add_prefix_to_identifier(identifier)
        "#{cookie_prefix}#{identifier}"
      end

      def get_value(identifier)
        @store[self.class.add_prefix_to_identifier(identifier)]
      end

      def set_value(identifier, value, expires = nil)
        @store[self.class.add_prefix_to_identifier(identifier)] = if @store.is_a?(ActionDispatch::Cookies::CookieJar)
          {value: value, expires: expires}
        else
          value
        end
      end

      def cookies
        @store.select { |key, value| key.to_s.start_with?(self.class.cookie_prefix) }.each_with_object({}) do |(k, v), m|
          m[k.gsub(self.class.cookie_prefix, "")] = v
        end
      end
    end
  end
end
