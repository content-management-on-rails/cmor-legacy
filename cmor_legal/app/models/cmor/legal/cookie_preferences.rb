module Cmor
  module Legal
    class CookiePreferences
      include ActiveModel::Model

      attr_accessor :cookies, :cookie_store

      def initialize(*attrs)
        super
        @cookies ||= ::Cmor::Legal::Configuration.cookies.call(cookie_store)
        @cookies.map(&:identifier).each do |identifier|
          singleton_class.class_eval do
            # attr_accessor c 
            define_method(identifier) do
              @cookies.find { |c| c.identifier == identifier }.value
            end

            define_method("#{identifier}=") do |value|
              @cookies.find { |c| c.identifier == identifier }.value = value
            end
          end
        end
      end

      def update_attributes(attributes)
        attributes.each do |identifier, value|
          @cookies.find { |c| c.identifier == identifier.to_sym }.value = value
        end
        save
      end

      def save
        @cookies.each { |c| c.save }
      end

      def accepted?(identifier)
        send(identifier)
      end

      def accepted_cookies
        cookies.select { |c| c.accepted? }
      end
    end
  end
end
